//
//  MapLocationButton.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 02/02/23.
//

import Foundation
import UIKit



class MapLocationButton: LocationButtonView {

    override init() {
        super.init()

        setImage(UIImage(systemName: "location.fill"), for: .userNotFocus)

        tintColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//?
    /// Replaces the original function to change the button status.
    /// - Parameter state: the button status can be:
    override func setButtonState(state: UIControl.State) {
        super.setButtonState(state: state)
        isEnabled = (state == .locationOccupied) ? false : true
    }
}
