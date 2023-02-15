//
//  LastSongView.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 13/02/23.
//

import Foundation
import UIKit
import MusicKit

public class AddCurrentSongView: UIView {
    
    var background: UIView!
    let warningImage = UIImage(systemName: "exclamationmark.triangle.fill")
    let myImageView:UIImageView = UIImageView()
    
    var albumImage: UIImageView!
    var currentTitle = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/5.5, y: UIScreen.main.bounds.midY/65, width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/15))
    
    var currentArtist =  UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/5.5, y: UIScreen.main.bounds.midY/50, width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/9))

    var currentAlbum = "Álbum"
    var circleImg = UIImage(systemName: "circle.fill")
    var mapView:MapView

    //var addSongButton: UIImageView!
    //var addSongButton: MapReactiveButton!
//    var AddSongButton : UIImageView {
//        let recebeImg = UIImage(systemName: "plus")
//        var myImageView:UIImageView = UIImageView()
//
//        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
////        myImageView.frame.size.width = .zero
////        myImageView.frame.size.height =
//
//        myImageView.tintColor = .white
//        myImageView.sizeToFit()
//        myImageView.image = recebeImg
//        myImageView =  UIImageView(frame: CGRect(x: self.bounds.maxX/28, y: self.bounds.maxY/6, width: self.bounds.size.width * 0.2, height: self.bounds.size.height * 0.8))
//        return myImageView
//    }

    //var songButtonView = SongButtonView()
    var state: UIControl.State = .addCurrentSong
  //  var reactiveButton = MapReactiveButton
    
    
    init(width:CGFloat, height:Int, mapView: MapView) {
        self.mapView = mapView
        super.init(frame: CGRect(x: 0, y: 0, width: Int(width), height: height))
        for family in UIFont.familyNames {
                print("family:", family)
                for font in UIFont.fontNames(forFamilyName: family) {
                    print("font:", font)
                }
            }
        
        setupBackground()
        setupImage()
        setupCurrentTitle()
        setupArtist()
        //setupAddSongButton()
        //songButtonView.setImage(self.addSongButton.image, for: .addCurrentSong)

        //        reactiveButton = MapReactiveButton(frame: CGRect(x: self.bounds.maxX/28, y: self.bounds.maxY/6, width: self.bounds.size.width * 0.2, height: self.bounds.size.height * 0.8))
//        addSubview(reactiveButton)
//        setupReactiveButtonConstraints()
//        songButtonView.setImage(AddSongButton, for: .addCurrentSong)
//        tintColor = .white

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackground() {
        self.background = UIView(frame: CGRect(x: self.bounds.maxX/90, y: self.bounds.maxY/15, width: self.bounds.size.width*1.09, height: self.bounds.size.height))
        self.background.backgroundColor = .black
        self.background.alpha = 0.8
        self.background.layer.cornerRadius = 8
        self.addSubview(background)
    }
    
    
    func setupImage() {
        self.albumImage = UIImageView(image: UIImage(named: "imagemCapa"))
        self.albumImage = UIImageView(frame: CGRect(x: self.bounds.maxX/28, y: self.bounds.maxY/6, width: self.bounds.size.width * 0.2, height: self.bounds.size.height * 0.8))
        self.albumImage.image = UIImage(named: "imagemCapa")
        self.albumImage.layer.masksToBounds = true
        self.albumImage.layer.cornerRadius = 8
        self.addSubview(self.albumImage)
    }
    
    func setupCurrentTitle (){
        self.currentTitle.text = "Sign of The Times"
    //    self.currentTitle = UILabel(frame: CGRect(x: self.bounds.midX, y: self.bounds.midY,width: self.bounds.size.width * 10,height: self.bounds.size.height * 10))
     //   self.currentTitle.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        self.currentTitle.textColor = .white
        self.currentTitle.textAlignment = .center
        self.currentTitle.numberOfLines = 1
        self.currentTitle.font = UIFont(name:"Inter", size: 5.0)
        self.currentTitle.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(currentTitle)
    }

    func setupArtist (){
        self.currentArtist.text = "Harry Styles . \(currentAlbum)"
    //    self.currentTitle = UILabel(frame: CGRect(x: self.bounds.midX, y: self.bounds.midY,width: self.bounds.size.width * 10,height: self.bounds.size.height * 10))
     //   self.currentTitle.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        self.currentArtist.textColor = .white
        self.currentArtist.textAlignment = .center
        self.currentArtist.numberOfLines = 1
        self.currentArtist.font = UIFont(name:"Inter", size: 20.0)
        self.currentArtist.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(currentArtist)
    }
    
//        func setupReactiveButtonConstraints() {
//            reactiveButton.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                reactiveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
//             //   currentSongView.centerXAnchor.constraint(equalTo: centerXAnchor),
//                reactiveButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
//                reactiveButton.heightAnchor.constraint(equalToConstant: 51)
//            ])
//        }
    
//    func setupAddSongButton() {
////        self.addSongButton = UIImageView(image: UIImage(systemName: "plus"))
////        self.addSongButton = UIImageView(frame: CGRect(x: self.bounds.maxX/1.5, y: self.bounds.maxY/6, width: self.bounds.size.width * 0.15, height: self.bounds.size.height * 0.5))
////        self.addSongButton.image =  UIImage(systemName: "plus")
////        self.addSongButton.tintColor = .white
//
////        let tap = UITapGestureRecognizer(target: self, action: #selector(AddCurrentSongView.tappedMe))
////
////        self.addSongButton.addGestureRecognizer(tap)
////        self.addSongButton.isUserInteractionEnabled = true
//        //self.addSongButton = MapReactiveButton(x: Float(self.bounds.maxX/1.5), y: Float(self.bounds.maxY/6), width: Float(self.bounds.size.width * 0.15), height: Float(self.bounds.size.height * 0.5), mapView: mapView)
//
//        //self.addSubview(self.addSongButton)
//    }
   
//    @objc func tappedMe()
//    {
//        print("Tapped on Image")
//
//       // self.addSongButton.setButtonState(state: state)
//
//    }
}



    

