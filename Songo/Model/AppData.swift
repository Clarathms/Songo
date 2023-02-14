//
//  AppData.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import CodableExtensions
import MapKit

class AppData: Codable {
    init() {}
    
    static var shared: AppData = AppData()
    
    private var addedMusic: [MusicPlacementModelPersistence] = []

    
    func update(musics: [MKAnnotation]) {
        
        let musicPlacementModels = musics.compactMap({$0 as? MusicPlacementModel})
        
        addedMusic.append(contentsOf: musicPlacementModels.map({MusicPlacementModelPersistence(music: $0)}))
    }
    
    func loadMusics() async -> [MusicPlacementModel] {
        var loadedMusics: [MusicPlacementModel] = []
        
        for music in self.addedMusic.map({MusicPlacementModel(persistence: $0)}) {
            await music.getApplePicture()
            loadedMusics.append(music)
        }
        print(loadedMusics.count)
        return loadedMusics
    }
    
    func saveData() {
           do {
               try self.save()
           } catch let err {
               print(err.localizedDescription)
           }
       }
    
    func loadData() {
        if let loaded = (try? AppData.load()) {
            Self.shared = loaded
        }
        else {
            Self.shared = AppData()
        }
    }
}
