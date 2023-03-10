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
    
    var currentStreaming: StreamChoice?
    var isConnected: Bool? = true
    
    static var shared: AppData = AppData()
    
    private var addedMusic: [MusicPlacementModelPersistence] = []
    
    func update(musics: [MKAnnotation]) {
        
        let musicPlacementModels = musics.compactMap({$0 as? MusicPlacementModel})
        addedMusic = musicPlacementModels.map({MusicPlacementModelPersistence(music: $0)})
    }
    
    func loadMusics() async -> [MusicPlacementModel] {
        var loadedMusics: [MusicPlacementModel] = []
        
        for music in self.addedMusic.map({MusicPlacementModel(persistence: $0)}) {
//            await music.getApplePicture()
            loadedMusics.append(music)
        }
//        loadedMusics = self.addedMusic.map({MusicPlacementModel(persistence: $0)})
        return loadedMusics
    }
    
//    func loadStreamId() -> StreamChoice {
//        return currentStreaming
//    }
    
    func saveData() {
           do {
               try self.save()
           } catch let err {
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
    class func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
                
                if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
                    return true
                }else{
                    defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                    return false
                }
    }
}

enum StreamChoice: Codable {
    case appleMusic
    case spotify
    case notLoggedIn
}
