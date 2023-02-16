//
//  AppData.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import CodableExtensions
import MapKit

var MusicService: MusicProtocol.Type = SpotifyService.self

class AppData: Codable {
    
//    func xxx() {
//
//        let escolha = 1
//
//        if escolha == 1 {
//            MusicService = AppleMusicService.self
//        } else {
//            MusicService = SpotifyService.self
//        }
//
//        let meuMusicService = MusicService.init()
//
//    }
    
    init() {}
    
//    var currentStreaming: MusicProtocol.Type
    
    static var shared: AppData = AppData()
    
    private var addedMusic: [MusicPlacementModelPersistence] = []
    
    func update(musics: [MKAnnotation]) {
        
        let musicPlacementModels = musics.compactMap({$0 as? MusicPlacementModel})
        addedMusic = musicPlacementModels.map({MusicPlacementModelPersistence(music: $0)})
//        addedMusic.append(contentsOf: musicPlacementModels.map({MusicPlacementModelPersistence(music: $0)}))
        print("added", addedMusic.count)
    }
    
    func chooseStreaming() {
    
    }
    
    func loadMusics() async -> [MusicPlacementModel] {
        var loadedMusics: [MusicPlacementModel] = []
        
        for music in self.addedMusic.map({MusicPlacementModel(persistence: $0)}) {
            loadedMusics.append(music)
        }
//        loadedMusics = self.addedMusic.map({MusicPlacementModel(persistence: $0)})
        print("loaded", loadedMusics.count)
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
