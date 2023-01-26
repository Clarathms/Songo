//
//  MapView.swift
//  Songo
//
//  Created by Amanda Melo on 23/01/23.
//

import Foundation
import MapKit
import UIKit
import CoreLocation

/// The visualization of the map.
class MapView: MKMapView  {
    
    //MARK: - Properties
    var reactiveButton = MapReactiveButton()
    var isLocationOn: Bool
    var isAuthenticated: Bool
    
    //MARK: - Initializers
    init(isLocationOn: Bool, isAuthenticated: Bool) {
        self.isLocationOn = isLocationOn
        self.isAuthenticated = isAuthenticated
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the `MapView` settings, `reactiveButton` and set the status of the user location with `showsUserLocation`.
    func setupMapView() {
            
        showsUserLocation = (isLocationOn ? true : false)
        addSubview(reactiveButton)
        mapType = .mutedStandard
        showsBuildings = false
    }
<<<<<<< Updated upstream
=======
//não está impactando em nada no momento (chamado em extensão do CLLocation)
    /// Set the center of the camera to the user`s location.
    /// - Parameter userLocation: the location of the user given by the LocationController.
    func setRegionToUserCurrentLocation(userLocation: CLLocation) {
        setCenter(userLocation.coordinate, animated: true)
    }
    
    /// Set the limited zoom region.
    /// - Parameter userLocation: the location of the user given by the LocationController.
    func setRegionToUserCurrentLocationWithZoomLimits(userLocation: CLLocation) {
        let region = MKCoordinateRegion.init(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        setRegion(region, animated: true)
    }
>>>>>>> Stashed changes
}
