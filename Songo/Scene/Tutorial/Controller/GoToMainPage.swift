//
//  GoToMainPage.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 30/01/23.
//
import Foundation
import ARKit
import SwiftUI

struct GoToMainPage : UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: TabBarController, context: Context) {
        
    }
    
    var appContainer: AppContainer = AppContainer()
    typealias UIViewControllerType = TabBarController
    

    func makeUIViewController(context: Context) -> TabBarController {
        var config = appContainer.createTabBarControllerScene()
        return config
    }
}

