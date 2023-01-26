//
//  MapReactiveButton.swift
//  Songo
//
//  Created by Amanda Melo on 24/01/23.
//

import Foundation
import UIKit

class MapReactiveButton: AddSongButtonView {
    
    override init() {
        super.init()
        
        setTitle(NSLocalizedString("Adicionar música atual", comment: "MapReactiveButton: title for MapReactiveButton"), for: .addCurrentSong)
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
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
