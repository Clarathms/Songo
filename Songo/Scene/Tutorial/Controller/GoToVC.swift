//
//  goToViewController.swift
//  TMReality
//
//  Created by Clara Thaís Maciel e Silva on 08/12/22.
//

import Foundation
import ARKit
import SwiftUI

struct GoToVC : UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: TabBarController, context: Context) {
        
    }
    
    var appContainer: AppContainer = AppContainer()
    typealias UIViewControllerType = TabBarController
    
    func makeUIViewController(context: Context) -> TabBarController {
        let config = appContainer.createTabBarControllerScene()
        
       // config.tabBarController?.navigationItem.hidesBackButton = true
        return config
    }
    
}

