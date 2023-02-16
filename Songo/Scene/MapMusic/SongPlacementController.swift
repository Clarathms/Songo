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
    
    let mapView: MapView
    let appleMusicService: AppleMusicService
    let locationController: LocationController
    
    init(mapView: MapView, locationController: LocationController, appleMusicService: AppleMusicService) {
        self.mapView = mapView
        self.locationController = locationController
        self.appleMusicService = appleMusicService
    }
    
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
    var allPlacements: [MKAnnotation] = []
    
    func addPlacement() async {
        guard let userLocation = locationController.location?.coordinate else { return }
        locationController.updateLastLocation()
        print(userLocation)

        let placement = await createPlacement(location: userLocation, music: self.appleMusicService)
        print(placement)
        
        displayedPlacements = placement
   
    }
    
    public func createPlacement (location: CLLocationCoordinate2D, music: AppleMusicService) async -> [MKAnnotation] {

        let placement = MusicPlacementModel(latitude: location.latitude, longitude: location.longitude, title: music.currentTitle, artist: music.currentArtist, musicData: music.currentPhotoData)
//        placement.musicPicture
        print(music.currentTitle)
        allPlacements.append(placement)
    
        return allPlacements
    }

}
