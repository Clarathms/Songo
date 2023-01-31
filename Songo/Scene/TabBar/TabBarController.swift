//
//  TabBarController.swift
//  Songo
//
//  Created by Amanda Melo on 25/01/23.
//

import Foundation
import UIKit
import SwiftUI


class TabBarController: UITabBarController {
    typealias Factory = MapSceneFactory
    
    let factory: Factory
    public var currentItem: UITabBarItem?

    
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
        
//        self.tabBarController?.navigationItem.hidesBackButton = true
        appleMusicController.checkAppleMusicAuthorization()
        locationController.checkLocationServices()
        setApplicationViewControllers()
        setupBar()
        setUpNavigationBar()

    }
    
    override func viewDidLoad() {
        
    }
   
    
    func setApplicationViewControllers() {
        
        // 1º tab
        let mapViewController = factory.createMapScene()
       // let mapNavigationController = UINavigationController(rootViewController: mapViewController)
        let mapNavigationController = factory.createMapScene()

        let playlistNavigationController = factory.createMapScene()
        let profileNavigationController = factory.createMapScene()
       // self.navigationItem.setHidesBackButton(true, animated:true)
        
        // 1 tab
        let mapTabBarItem = UITabBarItem(title: NSLocalizedString("Mapa", comment: "TabBarController: Name of the Map slot on Tab Bar."), image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        mapTabBarItem.tag = 0
        mapNavigationController.tabBarItem = mapTabBarItem
//
        // 2 tab
        let playlistTabBarItem = UITabBarItem(title: NSLocalizedString("Playlists", comment: "TabBarController: Name of the Playlists slot on Tab Bar."), image: UIImage(systemName: "music.note.house"), selectedImage: UIImage(systemName: "music.note.house.fill"))
        playlistTabBarItem.tag = 1
        playlistNavigationController.tabBarItem = playlistTabBarItem

        // 3 tab
        let profileTabBarItem = UITabBarItem(title: NSLocalizedString("Perfil", comment: "TabBarController: Name of the Profile slot on Tab Bar."), image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        profileTabBarItem.tag = 2
        profileNavigationController.tabBarItem = profileTabBarItem
        
        // Adds the ViewControllers to the TabBar
        setViewControllers([mapNavigationController,
                            playlistNavigationController,
                            profileNavigationController
                           ],
                           animated: false)
        currentItem = mapTabBarItem
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {currentItem = item}
    
    func setupBar() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
     //   tabBar.barTintColor = .blue
        tabBar.backgroundColor = .fundo
    }
    func setUpNavigationBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
//    func addConstraint() {
//     //   tabBarController.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tabBarController?.topAnchor.constraint(equalTo: self.view.topAnchor),
//            tabBarController?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            tabBarController?.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            tabBarController?.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//        ])
//    }
//    func addConstraint() {
//
//        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tabBarController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//])
//    }
}



