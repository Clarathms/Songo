//
//  LocationButtonView.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 09/02/23.
//

import Foundation
import UIKit

class LocationButtonView: UIButton {
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
            backgroundColor = isEnabled ? .fundo: .fundo
            tintColor = isEnabled ? .white : .white
        }
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        isEnabled = true // chama a cor definida
        widthAnchor.constraint(equalToConstant:  UIScreen.main.bounds.width/8 ).isActive = true
        heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/8 ).isActive = true
        addDropShadow()
        setTitleColor(.white, for: .userNotFocus)
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }

    
    
    
    
}
