//
//  SongPlacementCreationViewController.swift
//  Songo
//
//  Created by Amanda Melo on 01/02/23.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

class SongPlacementController {

    let mapView: MKMapView
    let mainButton = SongButtonView()
    private var mapViewController: UIViewController?
//    let locationController: LocationController
    var allPlacements: [MKAnnotation] = []
    private var displayedPlacements: [MKAnnotation]? {
        willSet {
            if let currentPlacements = displayedPlacements {
                mapView.removeAnnotations(currentPlacements)
            }
        }
        didSet {
            if let newPlacements = displayedPlacements {
                mapView.addAnnotations(newPlacements)
            }
        }
    }
    
    init(mapView: MKMapView, mapViewController: UIViewController? = nil, displayedPlacements: [MKAnnotation]? = nil) {
        self.mapView = mapView
        self.mapViewController = mapViewController
        self.displayedPlacements = displayedPlacements
    }

    public func createPlacement(location: CLLocationCoordinate2D, music: AppleMusicController) -> [MKAnnotation] {
        let placement = SongPlacementModel(latitude: location.latitude, longitude: location.longitude, musicTitle: music.currentTitle, musicPicture: music.currentPicture, artist: music.currentArtist)

        allPlacements.append(placement)
    
        return allPlacements
    }
}
