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
    let myImageView: UIImageView = UIImageView()
    
    lazy var albumImage: UIImageView = {
        let imageView = UIImageView(image: nil)
        return imageView
    }()
    
    var currentTitle2: String?
    var currentTitle = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/4.8, y: UIScreen.main.bounds.midY/25, width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/25))
    
    var currentArtist = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/4.8, y: UIScreen.main.bounds.midY/10, width: UIScreen.main.bounds.width/3, height:  UIScreen.main.bounds.height/25))
    
    var currentAlbum = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/1.8, y: UIScreen.main.bounds.midY/10, width: UIScreen.main.bounds.width/4, height:  UIScreen.main.bounds.height/25))
    var circleImg = UIImage(systemName: "circle.fill")
    var mapView: MapView
    
    var currentPhotoData: Data?
    var currentPhotoStringAdd: String?
    //var songButtonView = SongButtonView()
    var state: UIControl.State = .addCurrentSong
    var currentStreaming: MusicProtocol?
    var musicPicture: UIImage?
    
    //    lazy var musicPicture: UIImage? = {
    //        Task {
    //            await currentStreaming?.getCurrentPicture()
    //        }
    //       return UIImage(data: currentStreaming?.currentPhotoData ?? Data())
    //    }()
        
    
//    lazy var musicTitle: String? = { currentStreaming?.currentTitle }()
//    lazy var musicArtist: String? = { currentStreaming?.currentArtist }()
//    lazy var musicAlbum: String? = { currentStreaming?.currentAlbum}()
//
    var allPlacements: [MKAnnotation] = []
    
    //var reactiveButton = MapReactiveButton

    
    
    
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
        
        self.albumImage = UIImageView(frame: CGRect(x: self.bounds.maxX/28, y: self.bounds.maxY/6, width: self.bounds.size.width * 0.2, height: self.bounds.size.height * 0.8))
//        self.albumImage.image = musicPicture
        self.albumImage.layer.masksToBounds = true
        self.albumImage.layer.cornerRadius = 8
        self.addSubview(self.albumImage)
    }
    
    func setupCurrentTitle (){
      
//        self.currentTitle.text = MapView.musicTitle
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
    
    //    func createPlacement (music: AppleMusicService) async -> [MKAnnotation] {
    //        var musicPlacement: MusicPlacementModel
    ////            let placement = MusicPlacementModel(latitude: location.latitude, longitude: location.longitude, title: music.currentTitle, musicURL: music.currentURLPicture, artist: music.currentArtist)
    //        await musicPlacement.getApplePicture()
    //           // allPlacements.append(placement)
    //            AppData.shared.update(musics: allPlacements)
    //
    //            return await AppData.shared.loadMusics()
    //        }
    //
    }

   


