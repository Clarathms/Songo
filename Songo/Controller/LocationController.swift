//
//  LocationController.swift
//  Songo
//
//  Created by Amanda Melo on 25/01/23.
//

import Foundation
import CoreLocation
import MapKit

class LocationController: CLLocationManager {
    /// Reference to `MapView`.
    weak var mapDelegate: MapView?
    
    /// Variable that holds the user status as DidUpdate or Not.
    var userLocationDidUpdate: Bool = false
    
    /// Public variable that holds the user location permission status as On or Off.
    public var isLocationOn: Bool = false
    
    /// Public reference to hold the users last location.
    private var lastLocation: CLLocationCoordinate2D?
    
    /// Function that updates the reference `lastLocation`.
    public func updateLastLocation() {
        lastLocation = self.location?.coordinate
    }
    
    /// Function that is called to return the last users location.
    public func getLastLocation() -> CLLocationCoordinate2D? {
        return lastLocation
    }
    
    /// Check the localization authorization of the user.
    func checkLocationAuthorization() {
        switch authorizationStatus {
        // The user allow the location service only while the app is in use.
        case .authorizedWhenInUse:
            isLocationOn = true
            break
        // The user does not allow the location service. The location is disabled globally in Settings
        case .denied:
            isLocationOn = false
            break
        // The user location service was not provided. Than the request authorization is called.
        case .notDetermined:
            requestWhenInUseAuthorization()
        // The app is not authorized to use location services.
        case .restricted:
            isLocationOn = false
            break
        // The user location service is enabled at any time.
        case .authorizedAlways:
            isLocationOn = true
            break
        @unknown default:
            fatalError("The User Location authorization did not work!")
        }
    }
    
    /// Check if the location services are disabled for the entire device,
    /// or just for our app. If the location is on to the divice, the function
    /// call checkLocationAuthorization. Else, send a message to the
    /// user turn it on at Configurations.
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            return
        }
    }
}
