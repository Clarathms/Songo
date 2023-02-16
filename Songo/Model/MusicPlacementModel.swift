//
//  SongModel.swift
//  Songo
//
//  Created by Amanda Melo on 26/01/23.
//

import Foundation
import MapKit
import MusicKit
import CoreLocation
import SwiftUI


/// O que voce salva com o AppData
class MusicPlacementModelPersistence: Codable {
    
    var latitude: Double
    var longitude: Double
    var title: String?
    var artist: String?
    var musicData: Data?

    
    init(latitude: Double, longitude: Double, title: String?, artist: String?, musicData: Data?) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.artist = artist
        self.musicData = musicData
    }
    
    init(music: MusicPlacementModel) {
        latitude = music.latitude
        longitude = music.longitude
        title = music.title
        artist = music.artist
        musicData = music.musicData
    }
    
}


class MusicPlacementModel: NSObject, MKAnnotation {
    
    var latitude: Double
    var longitude: Double
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    //TODO: mostrar o dia e a hora que a música foi adicionada
    //    var addedAt: CVTimeStamp
    var title: String?
    var musicPicture: UIImage? { UIImage(data: musicData ?? Data()) }
    var artist: String?
    var musicData: Data?
    
    
    init(latitude: Double, longitude: Double, title: String?, artist: String?, musicData: Data?) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.artist = artist
        self.musicData = musicData
    }
    
    init(persistence: MusicPlacementModelPersistence) {
        latitude = persistence.latitude
        longitude = persistence.longitude
        title = persistence.title
        artist = persistence.artist
        musicData = persistence.musicData
    }
    
//    func getApplePicture() async  {
//
//        guard let url = self.musicURL else { return }
//
//        if let data = try? Data(contentsOf: url) {
//            if let image = UIImage(data: data){
//                musicPicture = image
//            }
//        }
//    }
//
//    func getSpotifyPicture() {
//        SpotifyService().appRemote.imageAPI?.fetchImage(forItem: musicImageIdentifier as! SPTAppRemoteImageRepresentable, with: CGSize.zero, callback: { [weak self] (image, error) in
//            if let error = error {
//                print("Error fetching track image: " + error.localizedDescription)
//            } else if let image = image as? UIImage {
//                self?.musicPicture = image
//            }
//        })
//    }
}


