//
//  TabBarController.swift
//  Songo
//
//  Created by Amanda Melo on 25/01/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    typealias Factory = MapSceneFactory
    
    let factory: Factory
    
    let locationController: LocationController
    let appleMusicController: AppleMusicController

    
    init(factory: Factory, locationController: LocationController, appleMusicController: AppleMusicController) {
        self.locationController = locationController
        self.factory = factory
        self.appleMusicController = appleMusicController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        locationController.checkLocationServices()
        setApplicationViewControllers()
    }
    
    func setApplicationViewControllers() {
        
        // 1º tab
        let mapViewController = factory.createMapScene()
        let mapNavigationController = UINavigationController(rootViewController: mapViewController)
        let mapTabBarItem = UITabBarItem(title: NSLocalizedString("Mapa", comment: "TabBarController: Name of the Map slot on Tab Bar."), image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        mapTabBarItem.tag = 0
        mapViewController.tabBarItem = mapTabBarItem
        
        // Adds the ViewControllers to the TabBar
        setViewControllers([mapNavigationController],animated: false)
    }
}
