//
//  MapPlaylistView.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import UIKit

class MapPlaylistView: UIView {
    
    let cellReuseIdentifier = "item"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .fundo
    }
}
