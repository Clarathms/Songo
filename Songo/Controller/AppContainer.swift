//
//  AppContainer.swift
//  Songo
//
//  Created by Amanda Melo on 23/01/23.
//

import Foundation
import MusicKit

class AppContainer {
    
    /// The `LocationController` used by the entire app
    private lazy var locationController: LocationController = LocationController()
    
    var currentStreaming: MusicProtocol?
    
    /// The `TabBarController` used by the entire app
    private lazy var tabBarController: TabBarController = TabBarController(factory: self, locationController: locationController, profileFactory: self, playlistFactory: self)
    
//    private lazy var mapPlaylistController: MapPlaylistController = MapPlaylistController(mainView: MapPlaylistView())
    
}
// ******* Cria a Cena de Mapa ********

protocol MusicServiceFactory {
    func updateStreaming()
}

extension AppContainer: MusicServiceFactory {
    
    ///
    /// Essa função deve ser chamada 2 vezes no código:
    /// - No `SceneDelegate`, para conectar e desconectar do Streaming
    /// - No `viewDidAppear` do `MapViewController`, para carregar informação no mapa.
    func updateStreaming() {
        
        if currentStreaming?.id == .none || currentStreaming?.id == .notLoggedIn {
            switch AppData.shared.currentStreaming {
            case .appleMusic:
                let Streaming: MusicProtocol.Type = AppleMusicService.self
                currentStreaming = Streaming.init()
                currentStreaming?.authenticate()

            case .spotify:
                let Streaming: MusicProtocol.Type = SpotifyService.self
                currentStreaming = Streaming.init()
                currentStreaming!.authenticate()
//                let sptService = currentStreaming as! SpotifyService
            default:
                break
            }
            
        }
        
    }
}
//MARK: - Map Factory
protocol MapSceneFactory {
    
    /// Returns an instance of MapViewController
    func createMapScene() -> MapViewController
    
}

extension AppContainer: MapSceneFactory {
    
    func createMapScene() -> MapViewController {
        return MapViewController(locationController: locationController, factory: self)
    }
    
}

// ******* Cria a Cena de perfil ********
protocol ProfileSceneFactory {
    func createProfileScene() -> ProfileViewController
    
}

extension AppContainer: ProfileSceneFactory {
    
    func createProfileScene() -> ProfileViewController {
        return ProfileViewController()
    }
    
}
// ******* Cria a Cena das Playlists ********
protocol PlaylistSceneFactory {
    func createPlaylistScene() -> PlaylistViewController
    
}

extension AppContainer: PlaylistSceneFactory {
    
    func createPlaylistScene() -> PlaylistViewController {
        return PlaylistViewController()
    }
    
}

protocol TabBarControllerSceneFactory {
    
    func createTabBarControllerScene() -> TabBarController
}

extension AppContainer: TabBarControllerSceneFactory {
    
    func createTabBarControllerScene() -> TabBarController {
        return tabBarController
    }
}

//protocol MapPlaylistSceneFactory {
//    func createMapPlaylistScene() -> MapPlaylistController
//}

//extension AppContainer: MapPlaylistSceneFactory {
//    func createMapPlaylistScene() -> MapPlaylistController {
//        return mapPlaylistController
//    }
//}
