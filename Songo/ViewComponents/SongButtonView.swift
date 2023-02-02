//
//  SongButtonVIew.swift
//  Songo
//
//  Created by Amanda Melo on 24/01/23.
//

import Foundation
import UIKit

/// Set the button that assumes different states.
class SongButtonView: UIButton {
    
    // MARK: - Properties
    var _state: UIControl.State = .normal
    
    // MARK: - Overrides
// override no state padrão chama o atual ou atualizada com um valor definido
    override public var state: UIControl.State {
        get {
            return _state
        }
        set(newType) {
            _state = newType
        }
    }
//Coloca cor no botão e no texto mas não entendi a sintaxe
    override public var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .blue: .white
            tintColor = isEnabled ? .white : .blue
        }
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        self.titleLabel?.font = .boldSystemFont(ofSize: 10)
        layer.cornerRadius = 12
        isEnabled = true
        widthAnchor.constraint(equalToConstant: 9 * UIScreen.main.bounds.width / 15).isActive = true
        heightAnchor.constraint(equalToConstant: 51).isActive = true
        addDropShadow()
//        setTitleColor(.white, for: .normal)
//        setTitleColor(.blue, for: .disabled)
        setTitleColor(.white, for: .normal)
        setTitleColor(.blue, for: .disabled)
///       talvez não precise

//        setTitle(NSLocalizedString("Adicionar música atual", comment: "MapReactiveButton: title for MapReactiveButton"), for: .addCurrentSong)
//        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// Function that changes the button state to Enabled or Disabled.
    /// - Parameter state: `isEnabled` or `disabled`
    public func setButtonState(state: UIControl.State) {
        self.state = state
        if state == .disabled{
            isEnabled = false
        }else{
            isEnabled = true
        }
        setNeedsLayout() // update button layout
    }
    
    /// Add the DropShadow effect on `CoguButtonView`.
    private func addDropShadow() {
        layer.shadowColor = UIColor.blue.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
}
