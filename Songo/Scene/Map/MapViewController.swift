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
    
//    typealias Factory = SongPlacementSceneFactory
    
//    var factory: Factory
    var appleMusicController: AppleMusicController = AppleMusicController()
    private var displayedPlacements: [MKAnnotation]? {
        willSet {
            if let currentPlacements = displayedPlacements {
                mainView.removeAnnotations(currentPlacements)
            }
        }
        didSet {
            if let newPlacements = displayedPlacements {
                mainView.addAnnotations(newPlacements)
            }
        }
    }
    var allPlacements: [MKAnnotation] = []
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
        mainView.setupMapView()
        setupMapReactiveButton()
        setupLocationManager()
        setupGestures()
        setupMapViewDelegate()
        registerMapannotationsViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isLocationOn = locationController.isLocationOn
        guard let location = locationController.location?.coordinate else { return }
        updateOverlay(location: location)
    }
    
    func setupMapReactiveButton() {
        mainView.reactiveButton.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
    }
    func setupMapLocationButton() {
        mainView.reactiveButton.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
    }
    
    /// Function that changes the button state and return it to the `reactiveButton`.
    func updateReactiveButton() {
        guard isLocationOn,
              let userLocation = locationController.location
        else { mainView.reactiveButton.setButtonState(state: .userNotFocus); return }
        
        let centerCoordinate = CLLocation(latitude: mainView.region.center.latitude, longitude: mainView.region.center.longitude)
        
        let distanceFromUserToMapCenterRegion = userLocation.distance(from: centerCoordinate)
        
        if distanceFromUserToMapCenterRegion > 5 {
            mainView.reactiveButton.setButtonState(state: .userNotFocus)
            return
        } //else
        mainView.reactiveButton.setButtonState(state: .addCurrentSong)
    }
    
    /// Sets the object that changes the properties by the state.
    @objc func handleButtonAction() {
        switch mainView.reactiveButton.state {
        case .userNotFocus:
            isLocationOn ? goToMyLocation() : requesLocationAuthorization()
        case .addCurrentSong:
            Task{
                await appleMusicController.getCurrentMusic()
                dump(appleMusicController.currentTitle)
                addPlacement()
            }
        default:
            break
        }
    }
    @objc func handleLocationButtonAction() {
        switch mainView.reactiveButton.state {
        case .userNotFocus:
            isLocationOn ? goToMyLocation() : requesLocationAuthorization()
        default:
            break
        }
    }
    func addPlacement() {
        guard let userLocation = locationController.location?.coordinate else { return }
        locationController.updateLastLocation()
        let placement = createPlacement(location: userLocation, music: appleMusicController)
        print(placement)
        displayedPlacements = placement
    }
    
    public func createPlacement(location: CLLocationCoordinate2D, music: AppleMusicController) -> [MKAnnotation] {

        let placement = SongPlacementModel(latitude: location.latitude, longitude: location.longitude, musicTitle: music.currentTitle)

        allPlacements.append(placement)
    
        return allPlacements
    }
    
    private func registerMapannotationsViews() {
        mainView.register(SongPlacementView.self, forAnnotationViewWithReuseIdentifier: SongPlacementView.reuseIdentifier)
    }
    /// Set the action button that redirect the user
    /// camera to the user location at the map.
    func goToMyLocation() {
        guard let userLocation = locationController.location else { return }
        isTrackingUserModeEnabled = true
        mainView.setCenter(userLocation.coordinate, animated: true)
//        updateAnnotations()
    }
    
    /// Set the interaction that add a new anotation.
    /// to the Array mapAnnotation.
//    func addAnnotation() {
//        guard let userLocation = locationController.location?.coordinate else { return }
//
//        if canAddAnnotation(userLocation) {
//            locationController.updateLastLocation()
////            let songSearchViewController = factory.createSongSearchScene()
//            let navController = UINavigationController(rootViewController: songSearchViewController)
//            present(navController, animated: true)
//        }
//    }
////
//    /// Check if user can add annotation.
//    /// - Parameter userLocation: Current user location.
//    /// - Returns: Returns if userLocation variable is not being used in any other annotation.
//    private func canAddAnnotation(_ userLocation: CLLocationCoordinate2D) -> Bool {
//        let allAnnotations = displayAnnotations
//        if !allAnnotations.isEmpty {
//            for annotations in allAnnotations{
//                if annotations.coordinate == userLocation {
//                    return false
//                }
//            }
//        }
//        return true
//    }
//    
//    //MARK: - Properties
//    var displayAnnotations = Set<SongPlacementModel>() {
//        didSet {
//            mainView.removeAnnotations(mainView.annotations)
//            mainView.addAnnotations(Array<SongPlacementModel>(displayAnnotations))
//        }
//    }
//    
    
    func requesLocationAuthorization() {
        present(redirectToSettingsAlert, animated: true, completion: nil)
    }
    let redirectToSettingsAlert: UIAlertController = {
        let title = NSLocalizedString("Configurações", comment: "MapViewController: title for alert redirectToSettings")
        let message = NSLocalizedString("Por favor, altere as permissões de localização do Cogu.", comment: "MapViewController: message for alert redirectToSettings")
        let preferredStyle = UIAlertController.Style.alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        return alert
    }()
}
