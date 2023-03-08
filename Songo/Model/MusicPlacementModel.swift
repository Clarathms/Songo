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
    var id: UUID

    
    init(latitude: Double, longitude: Double, title: String?, artist: String?, musicData: Data?, id: UUID) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.artist = artist
        self.musicData = musicData
        self.id = id
    }
    
    init(music: MusicPlacementModel) {
        latitude = music.latitude
        longitude = music.longitude
        title = music.title
        artist = music.artist
        musicData = music.musicData
        id = music.id
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
    var subtitle: String? { artist }
    var musicPicture: UIImage? { UIImage(data: musicData ?? Data()) }
    var artist: String?
//    var album: String?
    var musicData: Data?
    var id: UUID = UUID()
    
    
    init(latitude: Double, longitude: Double, title: String?, artist: String?, musicData: Data?) {
        self.latitude = latitude
        self.longitude = longitude
        //        self.addedAt = addedAt
        self.title = title
        self.artist = artist
//        self.album = album
        self.musicData = musicData
    }
    
    init(persistence: MusicPlacementModelPersistence) {
        latitude = persistence.latitude
        longitude = persistence.longitude
        title = persistence.title
        artist = persistence.artist
        musicData = persistence.musicData
        id = persistence.id
    }
    
}


