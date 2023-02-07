//
//  MapReactiveButton.swift
//  Songo
//
//  Created by Amanda Melo on 24/01/23.
//

import Foundation
import UIKit

class MapReactiveButton: SongButtonView {
    
    override init() {
        super.init()
        
        setTitle(NSLocalizedString("Adicionar música atual", comment: "MapReactiveButton: title for MapReactiveButton"), for: .addCurrentSong)
        setImage(UIImage(systemName: "plus.fill"), for: .addCurrentSong)
        
        setTitle(NSLocalizedString("Localização atual", comment: "MapReactiveButton: title for MapReactiveButton"), for: .userNotFocus)
        setImage(UIImage(systemName: "pencil"), for: .userNotFocus)
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
