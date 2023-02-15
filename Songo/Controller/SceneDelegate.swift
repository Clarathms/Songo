//
//  SceneDelegate.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 18/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appContainer: AppContainer = AppContainer()

    //var appContainer: AppContainer = AppContainer()
    var spotifyService: SpotifyService = SpotifyService()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // 1. Capture the scene if there is one into a variable
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // 3. Disble DarkMode
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        //        // 4. Create the view hierarchy
        //        let viewController = getRootViewController()
        
        //        // 5. Set the root view controller of the window
        //        window.rootViewController = viewController
        
        // 6. Set the window and make it keyAndVisible
        self.window = window
        window.makeKeyAndVisible()
        Task{
            
            if AppData.isFirstLaunch() == true {
                window.rootViewController = appContainer.createTabBarControllerScene()
            }else{
                window.rootViewController = ViewControllerTutorial()
            }
        }
        
        
        window.rootViewController = ViewControllerTutorial()
    }
    
    //TODO: acertar scene com a view devida para a autenticação com o Spotify
    //    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    //        guard let url = URLContexts.first?.url else { return }
    //            let parameters = rootViewController.appRemote.authorizationParameters(from: url)
    //            if let code = parameters?["code"] {
    //                rootViewController.responseCode = code
    //            } else if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
    //                rootViewController.accessToken = access_token
    //            } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
    //                print("No access token error =", error_description)
    //            }
    //    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        AppData.shared.saveData()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        if let _ = spotifyService.appRemote.connectionParameters.accessToken {
            spotifyService.appRemote.connect()
        }
    }
        
        func sceneWillResignActive(_ scene: UIScene) {
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
            if spotifyService.appRemote.isConnected {
                spotifyService.appRemote.disconnect()
            }
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
            print("Loading...")
            AppData.shared.loadData()
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
            AppData.shared.saveData()
        }
        
        

}
