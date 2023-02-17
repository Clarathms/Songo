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
    
//    private lazy var songPlacementCreationViewController: SongPlacementCreationViewController = SongPlacementCreationViewController()!
    
//    private lazy var appleMusicService: AppleMusicService = AppleMusicService()
    /// The `TabBarController` used by the entire app
    private lazy var tabBarController: TabBarController = TabBarController(factory: self, locationController: locationController, profileFactory: self, playlistFactory: self)
    
    private lazy var mapPlaylistController: MapPlaylistController = MapPlaylistController(mainView: MapPlaylistView())
    
}
// ******* Cria a Cena de Mapa ********

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
