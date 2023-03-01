//
//  CLLocationManagerDelegate.swift
//  Songo
//
//  Created by Amanda Melo on 26/01/23.
//

import Foundation
import UIKit
import CoreLocation

//MARK: - Extension: CL Location Manager Delegate
extension MapViewController: CLLocationManagerDelegate {
    
    /// Fucntion that set the LocationManager to the current `MapViewController` and start to update the user location.
    func setupLocationManager() {
        locationController.delegate = self
        locationController.mapDelegate = mainView
        locationController.startUpdatingLocation()
        locationController.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// Function that verify if ther user location is precise or approximated.
    /// - Returns: `true`or `false`
    func isPreciseLocationOn () -> Bool {
        return locationController.accuracyAuthorization == .fullAccuracy
    }
    
    /// Fucntion that is called every time that users location is updated.
    /// - Parameters:
    ///   - manager: MapViewController.
    ///   - locations: reference that contains the geographical location and altitude of a device.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if !locationController.userLocationDidUpdate {
            mainView.setRegionToUserCurrentLocationWithZoomLimits(userLocation: location)
            locationController.userLocationDidUpdate = true
        }
        
        if isTrackingUserModeEnabled { mainView.setRegionToUserCurrentLocation(userLocation: location) }
        
        updateOverlay(location: location.coordinate)
//        updateOverlay(location: CLLocationCoordinate2D(latitude: 40.748594910689874, longitude: -73.9856644020802))
        
        updateReactiveButton()
        //self.mapView.currentSongView?.addSongButton.updateReactiveButton()
        updateLocationButton()
    }
    
    /// Fucntion that is called every time that users changes the location services authorization.
    /// - Parameters:
    ///   - manager: MapViewController.
    ///   - status: can be tipe of: `authorizedWhenInUse`, `denied`, `notDetermined`, `restricted`, `authorizedAlways` and `default`.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationController.checkLocationAuthorization()
        isLocationOn = locationController.isLocationOn
        guard let location = locationController.location?.coordinate else { return }
        updateOverlay(location: location)
    }
    
}
