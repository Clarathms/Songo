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
    
    
    init(latitude: Double, longitude: Double, title: String?, musicURL: URL?, artist: String?) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.musicURL = musicURL
        self.artist = artist
    }
    
    init(music: MusicPlacementModel) {
        latitude = music.latitude
        longitude = music.longitude
        title = music.title
        musicURL = music.musicURL
        artist = music.artist
    }
    
}


class MusicPlacementModel: NSObject, MKAnnotation {
    
    var latitude: Double
    var longitude: Double
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    //    var addedAt: CVTimeStamp
    var title: String?
    var musicPicture: UIImage?
    var artist: String?
    var musicURL: URL?
    
    
    init(latitude: Double, longitude: Double, title: String?, musicURL: URL?, artist: String?) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.musicURL = musicURL
        self.artist = artist
    }
    
    init(persistence: MusicPlacementModelPersistence) {
        latitude = persistence.latitude
        longitude = persistence.longitude
        title = persistence.title
        musicURL = persistence.musicURL
        artist = persistence.artist
    }
    
    func getCurrentPicture() async  {
        
        guard let url = self.musicURL else {return}
        
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data){
                musicPicture = image
            }
        }
    }
    
    
}
