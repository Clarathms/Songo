//
//  LastSongView.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 13/02/23.
//

import Foundation
import UIKit
import MusicKit
import CoreLocation
import MapKit
import Combine

class AddCurrentSongView: UIView {
    var background: UIView!
    
    let myImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.maxX/1.35, y: UIScreen.main.bounds.maxY/30, width: UIScreen.main.bounds.width/18, height:  UIScreen.main.bounds.height/35))
    
    var albumImage = UIImageView(frame: CGRect(x: UIScreen.main.bounds.maxX/4, y: UIScreen.main.bounds.midY/25, width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/25))
    

    var currentTitle = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/4.8, y: UIScreen.main.bounds.midY/25, width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/25))
    
    var currentArtist = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/4.8, y: UIScreen.main.bounds.midY/10, width: UIScreen.main.bounds.width/4.5, height:  UIScreen.main.bounds.height/25))
    
    var currentAlbum = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/2, y: UIScreen.main.bounds.midY/10, width: UIScreen.main.bounds.width/4, height:  UIScreen.main.bounds.height/25))

    var separationDot = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/2.3, y: UIScreen.main.bounds.midY/20, width: UIScreen.main.bounds.width/16, height:  UIScreen.main.bounds.height/20))

    var mapView: MapView
    var artistaString: String = MapView.musicArtist ?? "Sem artista"
    var albumString: String = MapView.musicAlbum ?? "Sem album"
    
    var labelText = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/4.8, y: UIScreen.main.bounds.midY/10, width: UIScreen.main.bounds.width/3, height:  UIScreen.main.bounds.height/25))
    
    var state: UIControl.State = .addCurrentSong
    var currentStreaming: MusicProtocol?
    
    lazy var musicPicture: UIImage? = {
        Task {
            await currentStreaming?.getCurrentPicture()
            
        }
        return UIImage(data: currentStreaming?.currentPhotoData ?? Data())
    }()
    

    var imgListArray :[UIImage] = []
    var soundFrames: UIImage!
            
   
    
    
    
    init(width:CGFloat, height:Int, mapView: MapView, currentStreaming: MusicProtocol?) {
        self.mapView = mapView
        self.currentStreaming = currentStreaming
        super.init(frame: CGRect(x: 0, y: 0, width: Int(width), height: height))
           setupCurrentSongview()

       
    }
    func setupCurrentSongview() {
        setupBackground()
        setupImage()
        setupCurrentTitle()
        setupArtist()
        setupAlbum()
        setupDot()
        createAnimation()
      //  image()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupDot (){
        self.separationDot.text = "."
        self.separationDot.textColor = .white
        self.separationDot.font = UIFont.boldSystemFont(ofSize: 57)
       // self.separationDot.font = UIFont(name:"Inter", size: 45.0)
        addSubview(self.separationDot)
    }
    
    func setupBackground() {
        self.background = UIView(frame: CGRect(x: self.bounds.maxX/90, y: self.bounds.maxY/15, width: self.bounds.size.width*1.09, height: self.bounds.size.height))
        self.background.backgroundColor = .black
        self.background.alpha = 0.8
        self.background.layer.cornerRadius = 8
        self.addSubview(background)
    }
    
    
    func setupImage() {
        self.albumImage = UIImageView(image: musicPicture)
        self.albumImage = UIImageView(frame: CGRect(x: self.bounds.maxX/28, y: self.bounds.maxY/6, width: self.bounds.size.width * 0.2, height: self.bounds.size.height * 0.8))
        self.albumImage.image = musicPicture
        self.albumImage.layer.masksToBounds = true
        self.albumImage.layer.cornerRadius = 8
        self.addSubview(self.albumImage)
    }
    
    func setupCurrentTitle (){
      
        self.currentTitle.text = MapView.musicTitle
     //   print(currentStreaming?.currentTitle, "*********")
        self.currentTitle.textColor = .white
        self.currentTitle.textAlignment = .left
        self.currentTitle.numberOfLines = 1
        self.currentTitle.font = UIFont(name:"Inter", size: 5.0)
        self.currentTitle.font = UIFont.boldSystemFont(ofSize: 17)
        print( "\(String(describing: self.currentTitle.text)) + ******/////*******")
        self.addSubview(self.currentTitle)
        
    }
    
    func setupArtist (){
        self.currentArtist.text = MapView.musicArtist
        self.currentArtist.textColor = .white
        self.currentArtist.textAlignment = .left
        self.currentArtist.numberOfLines = 1
        self.currentArtist.font = UIFont(name:"Inter", size: 20.0)
        self.currentArtist.font = UIFont.systemFont(ofSize: 15)
       
        self.addSubview(currentArtist)
        
    }
    
    func setupAlbum (){
        self.currentAlbum.text = MapView.musicAlbum
        self.currentAlbum.textColor = .white
        self.currentAlbum.textAlignment = .left
        self.currentAlbum.numberOfLines = 1
        self.currentAlbum.font = UIFont(name:"Inter", size: 20.0)
        self.currentAlbum.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(currentAlbum)
    }
    

    func image() {
        self.albumImage.image = UIImage(named: "frame1")
    }
    func createAnimation () {
        for num in 1...10{
            //let strImageName : String = "foto\(num)"
            let image  = UIImage(named:"Frame \(num)")
            imgListArray.append(image!)
        }
        
        self.soundFrames = UIImage.animatedImage(with: imgListArray, duration: 1.5)
        myImageView.image = self.soundFrames
        myImageView.layoutIfNeeded()
        myImageView.startAnimating()
        addSubview(myImageView)
//        self.soundFrames.animationImages = imgListArray;
//        self.soundFrames.animationDuration = 2
//        //self.imageViewBox.animationRepeatCount = 2
//        self.soundFrames.startAnimating()
    }
    }

   


