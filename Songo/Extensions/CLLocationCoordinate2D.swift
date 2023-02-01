//
//  CLLocationCoordinate2D.swift
//  Songo
//
//  Created by Amanda Melo on 01/02/23.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    static func != (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude != rhs.latitude || lhs.longitude != rhs.longitude
    }
}
