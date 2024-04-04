//
//  StyleCell.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 01/03/23.
//

import Foundation
import UIKit
import MapKit

class StyleCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var artistLabel = UILabel(frame: .zero)
    var imgCapa: UIImage?
    var onDelete: () -> Void = {}
    var onTap: () -> Void = {}
//    var mapViewController: MapViewController
    
    lazy var imgView: UIImageView = {
        let imageView = UIImageView(image: nil)
        return imageView
    }()
    
    let deleteMusicAlert: UIAlertController = UIAlertController(title: "", message: "Tem certeza que deseja apagar essa música?", preferredStyle: .actionSheet)
    
       let button: UIButton = {
           let btn = UIButton()
           btn.setTitle("...", for: .normal)
//           btn.backgroundColor = .systemPink
           btn.titleLabel?.font = UIFont(name: "FiraSans-SemiBold", size: 20)
           return btn
       }()
       
       
    @objc func didTapButton(_ sender: UIButton) {
           onTap()
                                    
       }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(imgView)
        addSubview(button)

        setupTitleLabel()
        setupImage()
      //  setupArtistLabel()
        //setupButtonImage()
        
//        buttonConstrains()
        buttonConstrains()
        imgConstrains()
      //  artistConstrains()
        titleConstrains()
        deleteMusicAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil ))
        deleteMusicAlert.addAction(UIAlertAction(title: "Apagar", style: .default, handler: { _ in
            self.onDelete()
        }))
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("error")
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
    
   func buttonConstrains() {
       button.translatesAutoresizingMaskIntoConstraints = false
      // button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
              button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
              button.widthAnchor.constraint(equalToConstant: 100).isActive = true
              button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
       button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true

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
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "FiraSans-SemiBold", size: 16)
//        titleLabel.backgroundColor = .red
    }
    
    func titleConstrains() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor,constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.button.leadingAnchor, constant: 20),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
       //     self.artistLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 20)

        ])
    }
    
    func setupArtistLabel() {
        artistLabel.numberOfLines = 0
        artistLabel.adjustsFontSizeToFitWidth = true
        artistLabel.textColor = .white
        artistLabel.font = UIFont(name: "FiraSans-Light", size: 16)

    }
    
    func artistConstrains() {

        self.artistLabel.translatesAutoresizingMaskIntoConstraints = false
       // button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        
        self.artistLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        self.artistLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.artistLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        self.artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
    }
    
    
    func setup(from annotation:MKAnnotation) {
        contentView.isUserInteractionEnabled = false
        
        guard let data = annotation as? MusicPlacementModel else {
            return
        }
        
        self.titleLabel.text = data.title ?? "No Title"
        self.artistLabel.text = data.artist ?? "No Artist"
        
        
        if let imageCell = data.musicPicture {
            self.imgView.image = imageCell
        }
        
        self.backgroundColor = .fundoPlaylist
        self.selectionStyle = .none
        
        self.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
    }
}


