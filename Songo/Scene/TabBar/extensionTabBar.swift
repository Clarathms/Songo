//
//  extensionTabBarController.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 31/01/23.
//

import Foundation
import UIKit
extension TabBarController: TabBarNavigationController {
    func forceNavigation(to tab: Int, sender: UIViewController) {
        if let senderNavigationController = sender.navigationController {
            senderNavigationController.popToRootViewController(animated: true)
        }
        guard let viewControllers = viewControllers else { return }
        guard let tabBarItems = tabBar.items else { return }
        selectedViewController = viewControllers[tab]
        currentItem = tabBarItems[tab]
    }
    func getViewController(for tab: Int) -> UIViewController? {
        guard let viewControllers = viewControllers else { return nil }
        return viewControllers[tab]
    }
}
