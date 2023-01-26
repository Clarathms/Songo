//
//  SongModel.swift
//  Songo
//
//  Created by Amanda Melo on 26/01/23.
//

import Foundation
import MapKit

class SongModel: NSObject, MKAnnotation{
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    var addedAt: CVTimeStamp
    
    init(latitude: Double, longitude: Double, addedAt: CVTimeStamp) {
        self.latitude = latitude
        self.longitude = longitude
        self.addedAt = addedAt
    }
//    //TODO: When multiple annotations can ocupy the same location, this function will be obsolute.
//    public static func == (lhs: SongModel, rhs: SongModel) -> Bool{
//        return lhs.isEqual(rhs)
//    }
//
//    override func isEqual(_ object: Any?) -> Bool {
//        if let rhs = object as? SongModel{
//            return self.coordinate == rhs.coordinate        }
//        return false
//    }
}
