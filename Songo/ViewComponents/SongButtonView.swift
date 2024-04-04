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
            //backgroundColor = isEnabled ? .black: .black
            tintColor = isEnabled ? .white : .white
        }
    }
    
    // MARK: - Initializers
    init(x: Float, y: Float, width: Float, height: Float) {
        super.init(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height)))
        
    
                
        self.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 10)
        layer.cornerRadius = 10
        isEnabled = true
//        widthAnchor.constraint(equalToConstant: 30 * UIScreen.main.bounds.width / 5).isActive = true
//        heightAnchor.constraint(equalToConstant: 70).isActive = true
        addDropShadow()
//        setTitleColor(.white, for: .normal)
//        setTitleColor(.blue, for: .disabled)'
        //setTitle("teste", for: .addCurrentSong)
        tintColor = .white
        setTitleColor(.white, for: .userNotFocus)
        setTitleColor(.white, for: .addCurrentSong)
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
