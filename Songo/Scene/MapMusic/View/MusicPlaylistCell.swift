//
//  MusicPlaylistCell.swift
//  Songo
//
//  Created by Amanda Melo on 27/02/23.
//

import Foundation
import UIKit

class MusicPlaylistCell: UICollectionViewCell {
    
    let imageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "film", withConfiguration:UIImage.SymbolConfiguration(weight: .light))
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .lightGray
        return view
    }()
    
    let label:UILabel = {
        let label = UILabel()
        label.text = "No Title"
        label.font = UIFont(name: "FiraSans-Regular", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    
    override init(frame: CGRect) {
        print(frame)
        super.init(frame: frame)
        // add subviews
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints=false
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints=false
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(lessThanOrEqualTo: label.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
}
