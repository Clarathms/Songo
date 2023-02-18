//
//  AppContainer.swift
//  Songo
//
//  Created by Amanda Melo on 23/01/23.
//

import Foundation

class AppContainer {
    /// The `LocationController` used by the entire app
    private lazy var locationController: LocationController = LocationController()
    
    private var currentStreaming: MusicProtocol?
    
    /// The `TabBarController` used by the entire app
    private lazy var tabBarController: TabBarController = TabBarController(factory: self, locationController: locationController, profileFactory: self, playlistFactory: self)
    
    private lazy var mapPlaylistController: MapPlaylistController = MapPlaylistController(mainView: MapPlaylistView())
    
}
// ******* Cria a Cena de Mapa ********

protocol MusicServiceFactory {
    func updateStreaming() -> MusicProtocol?
}

extension AppContainer: MusicServiceFactory {
    func updateStreaming() -> MusicProtocol? {
        if AppData.shared.currentStreaming == .none {
            switch AppData.shared.currentStreaming {
            case .appleMusic:
                let Streaming: MusicProtocol.Type = AppleMusicService.self
                currentStreaming = Streaming.init()
                print("escolha --------", AppData.shared.currentStreaming)
                return currentStreaming
                
            case .spotify:
                let Streaming: MusicProtocol.Type = SpotifyService.self
                currentStreaming = Streaming.init()
                currentStreaming!.authenticate()
                print("escolha --------", AppData.shared.currentStreaming)
                return currentStreaming
                
            case .none:
                break
            }
        }
        print("não entrou dnv", currentStreaming?.id)
        print(AppData.shared.currentStreaming)
        return currentStreaming
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

protocol MapPlaylistSceneFactory {
    func createMapPlaylistScene() -> MapPlaylistController
}

extension AppContainer: MapPlaylistSceneFactory {
    func createMapPlaylistScene() -> MapPlaylistController {
        return mapPlaylistController
    }
}
