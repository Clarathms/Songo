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
    var musicURL: URL?
    var artist: String?
    var musicImageIdentifier: String?
    
    init(latitude: Double, longitude: Double, title: String?, musicURL: URL? = nil, artist: String?, musicImageIdentifier: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.musicURL = musicURL
        self.artist = artist
        self.musicImageIdentifier = musicImageIdentifier
    }
    
    init(music: MusicPlacementModel) {
        latitude = music.latitude
        longitude = music.longitude
        title = music.title
        musicURL = music.musicURL
        artist = music.artist
        musicImageIdentifier = music.musicImageIdentifier
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
    var musicPicture: UIImage?
    var artist: String?
    var musicURL: URL?
    var musicImageIdentifier: String?
    
    
    init(latitude: Double, longitude: Double, title: String?, musicURL: URL? = nil, artist: String?, musicImageIdentifier: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.musicURL = musicURL
        self.artist = artist
        self.musicImageIdentifier = musicImageIdentifier
    }
    
    init(persistence: MusicPlacementModelPersistence) {
        latitude = persistence.latitude
        longitude = persistence.longitude
        title = persistence.title
        musicURL = persistence.musicURL
        artist = persistence.artist
        musicImageIdentifier = persistence.musicImageIdentifier
    }
    
    func getApplePicture() async  {
        
        guard let url = self.musicURL else { return }
        
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data){
                musicPicture = image
            }
        }
    }
    
    func getSpotifyPicture() {
        SpotifyService().appRemote.imageAPI?.fetchImage(forItem: musicImageIdentifier as! SPTAppRemoteImageRepresentable, with: CGSize.zero, callback: { [weak self] (image, error) in
            if let error = error {
                print("Error fetching track image: " + error.localizedDescription)
            } else if let image = image as? UIImage {
                self?.musicPicture = image
            }
        })
    }
}


