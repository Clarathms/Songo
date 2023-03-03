//
//  StyleCell.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 01/03/23.
//

import Foundation
import UIKit

class StyleCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var artistLabel = UILabel(frame: .zero)
    var imgCapa: UIImage?
    let threeDots: UILabel = UILabel()

    
    lazy var imgView: UIImageView = {
        let imageView = UIImageView(image: nil)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(imgView)
        
        setupTitleLabel()
        setupImage()
//        setupArtistLabel()
        setupButtonImage()
        
//        buttonConstrains()
        
        imgConstrains()
//        artistConstrains()
        titleConstrains()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    func set(image: UIImage ) {
        imgCapa = image
        
    }
    
    func setupImage(){
       // imageView?.sizeThatFits(CGSize( width: 50, height: 50))
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 15
        imgView.clipsToBounds = true
        //imgView.image?.resizingMode
        imgView.image = imgCapa
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
    
    func setupButtonImage () {
        self.threeDots.text =  "..."
        self.threeDots.font = .systemFont(ofSize: 16, weight: .bold)
        
        
    }
    
    func buttonConstrains() {
        self.threeDots.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          //  self.imgView.topAnchor.constraint(equalTo: self.topAnchor),
            self.threeDots.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 50),
           // self.imgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.threeDots.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.threeDots.heightAnchor.constraint(equalToConstant: 80),
            self.threeDots.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.threeDots.widthAnchor.constraint(equalTo: self.imgView.heightAnchor, multiplier: 0.7)
          //  self.imgView.widthAnchor.constraint(equalTo: self.widthAnchor)

        ])
        
    }
    func imgConstrains() {
        self.imgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          //  self.imgView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
           // self.imgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imgView.heightAnchor.constraint(equalToConstant: 80),
            self.imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.imgView.widthAnchor.constraint(equalTo: self.imgView.heightAnchor, multiplier: 0.7)
          //  self.imgView.widthAnchor.constraint(equalTo: self.widthAnchor)

        ])
    }
    func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    func titleConstrains() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor,constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
       //     self.artistLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 20)

        ])
    }
    
    func setupArtistLabel() {
        artistLabel.numberOfLines = 0
        artistLabel.adjustsFontSizeToFitWidth = true
        artistLabel.textColor = .white
    }
    
    func artistConstrains() {
        self.artistLabel.leadingAnchor.constraint(equalTo: self.artistLabel.leadingAnchor).isActive = true
        self.artistLabel.topAnchor.constraint(equalTo:  self.titleLabel.bottomAnchor,constant: 20).isActive = true
        self.artistLabel.trailingAnchor.constraint(equalTo: self.artistLabel.trailingAnchor).isActive = true
        self.artistLabel.bottomAnchor.constraint(equalTo: self.artistLabel.bottomAnchor).isActive = true
    }
}
