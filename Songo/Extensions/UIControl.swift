//
//  UIControl.swift
//  Songo
//
//  Created by Amanda Melo on 24/01/23.
//

import Foundation
import UIKit

extension UIControl.State {
    static let locationOccupied = UIControl.State(rawValue: 1 << 16)
    static let addCurrentSong = UIControl.State(rawValue: 1 << 17)//????
    static let userNotFocus = UIControl.State(rawValue: 1 << 18)
}
