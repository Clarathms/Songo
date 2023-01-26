//
//  MapViewController.swift
//  Songo
//
//  Created by Amanda Melo on 23/01/23.
//

import Foundation
import CoreLocation
import MapKit

/// The View Controller of the Map Scene
class MapViewController: BaseViewController<MapView> {
    
    

    
    let locationController: LocationController
    // Variable that holds the value (true or false) if the user is logged or not.
    var isAuthenticated: Bool
    // Variable that holds the value (true or false) if the user authorized the location service or not.
    var isLocationOn: Bool {
        didSet {
            setupLocationManager()
            mainView.removeOverlays(mainView.overlays)
            mainView.isLocationOn = isLocationOn
            mainView.setupMapView()
        }
    }
    // Variable that holds the value (true or false) if the camera should follow the user location or not.
    var isTrackingUserModeEnabled: Bool = false
    
    init(locationController: LocationController) {
        self.locationController = locationController
        isAuthenticated = true
        isLocationOn = locationController.isLocationOn
        
        super.init(mainView: MapView(isLocationOn: isLocationOn, isAuthenticated: isAuthenticated))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOverlay(location: CLLocationCoordinate2D) {
        let newCircle = MKCircle(center: location, radius: 500)
        mainView.removeOverlays(mainView.overlays)
        mainView.addOverlay(newCircle)
    }
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isLocationOn = locationController.isLocationOn
        guard let location = locationController.location?.coordinate else { return }
        updateOverlay(location: location)
    }
}
