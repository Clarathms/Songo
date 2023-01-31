//
//  ProtocolTabBarController.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 31/01/23.
//

import Foundation
import UIKit

protocol TabBarNavigationController {
    
    /// Forces a navigation to a specific tab by its index
    /// - Parameters:
    ///   - tab: The index of the destination tab
    ///   - sender: The UIViewController that sent the action
    func forceNavigation(to tab: Int, sender: UIViewController)
    /// Get view controller by its tab index.
    /// - Parameter tab: The index of the destination tab.
    func getViewController(for tab: Int) -> UIViewController?
}
