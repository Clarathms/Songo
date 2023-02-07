//
//  MapLocationButton.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 02/02/23.
//

import Foundation
import UIKit

class MapLocationButton: SongButtonView {
    
    override init() {
        super.init()
        
        setTitle(NSLocalizedString("Adicionar música atual", comment: "MapReactiveButton: title for MapReactiveButton"), for: .addCurrentSong)
        
//        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        setTitle(NSLocalizedString("Localização atual", comment: "MapReactiveButton: title for MapReactiveButton"), for: .userNotFocus)
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
