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
    typealias ContactFactory = ContactSceneFactory
    typealias PlaylistFactory = PlaylistSceneFactory

    let contactFactory : ContactFactory
    let playlistFactory : PlaylistFactory
    let factory: Factory
    public var currentItem: UITabBarItem?

    
    let locationController: LocationController
    
    init(factory: Factory, locationController: LocationController,profileFactory: ContactFactory, playlistFactory: PlaylistFactory) {
        self.locationController = locationController
        self.factory = factory
        self.contactFactory = profileFactory
        self.playlistFactory = playlistFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        
        locationController.checkLocationServices()
        setApplicationViewControllers()
        setupBar()
        setUpNavigationBar()

    }
    
    override func viewDidLoad() {
        
    }
   
    
    func setApplicationViewControllers() {
        
        // 1º tab
        let mapNavigationController = factory.createMapScene()

        let playlistNavigationController = playlistFactory.createPlaylistScene()
        let contactNavigationController = contactFactory.createContactScene()
        
        // 1 tab
        let mapTabBarItem = UITabBarItem(title: NSLocalizedString("MapTabBar", comment: "TabBarController: Name of the Map slot on Tab Bar."), image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        mapTabBarItem.tag = 0
        mapNavigationController.tabBarItem = mapTabBarItem
//
        // 2 tab
        let playlistTabBarItem = UITabBarItem(title: NSLocalizedString("Playlists", comment: "TabBarController: Name of the Playlists slot on Tab Bar."), image: UIImage(systemName: "music.note.house"), selectedImage: UIImage(systemName: "music.note.house.fill"))
        playlistTabBarItem.tag = 1
        playlistNavigationController.tabBarItem = playlistTabBarItem

        // 3 tab
        let profileTabBarItem = UITabBarItem(title: NSLocalizedString("Contact Us", comment: "TabBarController: Name of the Contact Us slot on Tab Bar."), image: UIImage(systemName: "questionmark.circle"), selectedImage: UIImage(systemName: "questionmark.circle.fill"))
        profileTabBarItem.tag = 2
        contactNavigationController.tabBarItem = profileTabBarItem
        
        // Adds the ViewControllers to the TabBar
        setViewControllers([mapNavigationController,
                            //playlistNavigationController,
                            contactNavigationController
                           ],
                           animated: false)
        currentItem = mapTabBarItem
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {currentItem = item}
    
    func setupBar() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
     //   tabBar.barTintColor = .blue
        tabBar.backgroundColor = .fundoPlaylist
    }
    func setUpNavigationBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
}



