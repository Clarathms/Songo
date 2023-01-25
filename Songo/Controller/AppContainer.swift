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
