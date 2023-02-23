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
    weak var appleMusicService: AppleMusicService?
    weak var spotifyService: SpotifyService?
    var background: UIView!
    let myImageView:UIImageView = UIImageView()
    
    var albumImage: UIImageView!
    var currentTitle = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/5.5, y: UIScreen.main.bounds.midY/65, width: UIScreen.main.bounds.width/3, height:  UIScreen.main.bounds.height/15))
    
    var currentArtist =  UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/5.8, y: UIScreen.main.bounds.midY/50, width: UIScreen.main.bounds.width/3, height:  UIScreen.main.bounds.height/9))
    
    var currentAlbum = UILabel(frame: CGRect(x: UIScreen.main.bounds.maxX/2, y: UIScreen.main.bounds.midY/50, width: UIScreen.main.bounds.width/3, height:  UIScreen.main.bounds.height/9))
    var circleImg = UIImage(systemName: "circle.fill")
    var mapView:MapView
    var Streaming: MusicProtocol.Type?
    //    var musicPlacement: MusicPlacementModelPersistence
    
    
    //var songButtonView = SongButtonView()
    var state: UIControl.State = .addCurrentSong
    var musicURL : URL?
    var musicPicture: UIImage?
    var allPlacements: [MKAnnotation] = []
    
    //var reactiveButton = MapReactiveButton
    var streaming: MusicProtocol.Type?
    private var currentStreaming: MusicProtocol?
    
    private var currentStreaming2: StreamChoice?
    

    //  //  var appData: AppData
    //    var streamingReceiver: MusicProtocol = MapView.recebeStreaming ?? nil
    
    init(width:CGFloat, height:Int, mapView: MapView, appleMusicService: AppleMusicService) {
        self.mapView = mapView
        super.init(frame: CGRect(x: 0, y: 0, width: Int(width), height: height))
        Task {
           
            if currentStreaming == nil {
                print("***********  Vai crashar!!  **************")
                self.currentTitle.text = "Sem titulo atual"
                self.currentArtist.text = "Sem artista atual"
                self.currentAlbum.text = "Sem album atual"
            }
            else {
                _ = await GetData(music: currentStreaming!)
            }
        }
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
        self.albumImage = UIImageView(image: musicPicture)
        self.albumImage = UIImageView(frame: CGRect(x: self.bounds.maxX/28, y: self.bounds.maxY/6, width: self.bounds.size.width * 0.2, height: self.bounds.size.height * 0.8))
        self.albumImage.image = musicPicture
        self.albumImage.layer.masksToBounds = true
        self.albumImage.layer.cornerRadius = 8
        self.addSubview(self.albumImage)
    }
    
    func setupCurrentTitle (){
        //  self.currentTitle.text = "Sign of The Times"
        
        self.currentTitle.textColor = .white
        self.currentTitle.textAlignment = .center
        self.currentTitle.numberOfLines = 1
        self.currentTitle.font = UIFont(name:"Inter", size: 5.0)
        self.currentTitle.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(self.currentTitle)
        
    }
    
    func setupArtist (){
        //  self.currentArtist.text = "Harry Styles . \(currentAlbum)"
        
        self.currentArtist.textColor = .white
        self.currentArtist.textAlignment = .center
        self.currentArtist.numberOfLines = 1
        self.currentArtist.font = UIFont(name:"Inter", size: 20.0)
        self.currentArtist.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(currentArtist)
    }
    func setupAlbum (){
        //  self.currentArtist.text = "Harry Styles . \(currentAlbum)"
        
        self.currentAlbum.textColor = .white
        self.currentAlbum.textAlignment = .center
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
    func getApplePicture() async {
        guard let url = self.musicURL else { return }
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data){
                self.musicPicture = image
                print("--------------------///f------------")
                print(appleMusicService?.currentURLPicture!)
            }
        }
    }
    func GetCurrentStreaming() {
        switch AppData.shared.currentStreaming {
        case .appleMusic:
            let Streaming: MusicProtocol.Type = AppleMusicService.self
            currentStreaming = Streaming.init()
            
        case .spotify:
            let Streaming: MusicProtocol.Type = SpotifyService.self
            currentStreaming = Streaming.init()
            
        default:
            print("-------brekou")
            break
        }
//
//        func updateStreaming2() {
//            switch AppData.shared.currentStreaming {
//            case .appleMusic:
//                currentStreaming2 = .appleMusic
//
//
//            case .spotify:
//                currentStreaming2 = .spotify
//
//            default:
//                print("-------brekou")
//                break
//            }
//        }
    }
    func GetData (music: MusicProtocol) {
        self.currentTitle.text = music.currentTitle
        self.currentArtist.text = music.currentArtist
        self.currentAlbum.text = music.currentAlbum
        
   }
   
}


    
//            switch AppData.shared.currentStreaming {
//            case .appleMusic:
//                await
//                appleMusicService.getCurrentMusic()
//                self.currentTitle.text = appleMusicService.currentTitle
//                self.currentArtist.text = appleMusicService.currentArtist
//                self.currentAlbum.text = appleMusicService.currentAlbum
//                // self.albumImage.image = appleMusicService.currentPicture
//
//                //            self.musicPicture = UIImage(data: <#T##Data#>appleMusicService.currentURLPicture
//                // print(currentTitle.text)
//                // await getApplePicture()
//            case .spotify:
//                await
//                spotifyService.getCurrentMusic()
//                self.currentTitle.text = spotifyService.currentTitle
//                self.currentArtist.text = spotifyService.currentArtist
//                self.currentAlbum.text = spotifyService.currentAlbum
//            default:
//                print("N U L O")
//            }
