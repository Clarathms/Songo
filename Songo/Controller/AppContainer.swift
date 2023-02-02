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
    
    private lazy var appleMusicController: AppleMusicController = AppleMusicController()
    /// The `TabBarController` used by the entire app
    private lazy var tabBarController: TabBarController = TabBarController(factory: self, locationController: locationController, appleMusicController: appleMusicController)
    
}
//MARK: - Map Factory
protocol MapSceneFactory {
    
    /// Returns an instance of MapViewController
    func createMapScene() -> MapViewController
    
}

extension AppContainer: MapSceneFactory {
    
    func createMapScene() -> MapViewController {
        return MapViewController(locationController: locationController)
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
//
//protocol SongPlacementSceneFactory {
//    func createSongPlacement() -> SongPlacementCreationViewController
//}
//
//extension AppContainer: SongPlacementSceneFactory {
//    func createSongPlacement() -> SongPlacementCreationViewController {
//        return songPlacementCreationViewController
//    }
//}
