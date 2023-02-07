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
    let appleMusicController: AppleMusicController
    let locationController: LocationController
    
    init(mapView: MapView, locationController: LocationController, appleMusicController: AppleMusicController) {
        self.mapView = mapView
        self.locationController = locationController
        self.appleMusicController = appleMusicController
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
    
    func addPlacement() {
        guard let userLocation = locationController.location?.coordinate else { return }
        locationController.updateLastLocation()
        print(userLocation)
        Task{
            let placement = await createPlacement(location: userLocation, music: self.appleMusicController)
            print(placement)
            
            displayedPlacements = placement
        }
    }
    
    public func createPlacement (location: CLLocationCoordinate2D, music: AppleMusicController) async -> [MKAnnotation] {

        let placement = await MusicPlacementModel(latitude: location.latitude, longitude: location.longitude, title: music.currentTitle, musicPicture: music.getCurrentPicture(), artist: music.currentArtist)
        print(music.currentTitle)
        allPlacements.append(placement)
    
        return allPlacements
    }

}
