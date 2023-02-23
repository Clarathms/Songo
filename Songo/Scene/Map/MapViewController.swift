//
//  MapViewController.swift
//  Songo
//
//  Created by Amanda Melo on 23/01/23.
//

import Foundation
import CoreLocation
import MapKit
import Combine
import MusicKit


/// The View Controller of the Map Scene
class MapViewController: BaseViewController<MapView> {
    
    typealias Factory = MapPlaylistSceneFactory & MusicServiceFactory
    
    var factory: Factory
    var appleMusicService: AppleMusicService = AppleMusicService()
    let locationController: LocationController
    // Variable that holds the value (true or false) if the user authorized the location service or not.
    var isLocationOn: Bool {
        didSet {
            setupLocationManager()
            mainView.removeOverlays(mainView.overlays)
            mainView.setupMapView()
        }
    }
    // Variable that holds the value (true or false) if the camera should follow the user location or not.
    var isTrackingUserModeEnabled: Bool = false
    
    var currentZoomLevel: Int?  {
        didSet {
            // if we have crossed the max zoom level, request a refresh
            // so that all annotations are redrawn with clustering enabled/disabled
            guard let currentZoomLevel = self.currentZoomLevel else { return }
            guard let previousZoomLevel = oldValue else { return }

            if isRefreshRequired(previousZoomLevel: previousZoomLevel, currentZoomLevel: currentZoomLevel) {
                refreshMap()
            }
        }
    }
    
    // Constant that holds the value of the maximum zoom level where there annotations should not cluster.
    private let maxZoomLevel = 9

    // Computed Variable that set if the annotations will cluster or not.
    var shouldCluster: Bool {
        if let zoomLevel = currentZoomLevel, zoomLevel <= maxZoomLevel {
            return false
        }
        return true
    }
    
    private func isRefreshRequired(previousZoomLevel: Int, currentZoomLevel: Int) -> Bool {
        var refreshRequired = false
        if currentZoomLevel > self.maxZoomLevel && previousZoomLevel <= self.maxZoomLevel {
            refreshRequired = true
        }
        if currentZoomLevel <= self.maxZoomLevel && previousZoomLevel > self.maxZoomLevel {
            refreshRequired = true
        }
        return refreshRequired
    }
    
    private func refreshMap() {
        let annotations = mainView.annotations
        mainView.removeAnnotations(annotations)
        mainView.addAnnotations(annotations)
    }
    
    init(locationController: LocationController, factory: Factory) {
        self.locationController = locationController
        isLocationOn = locationController.isLocationOn
        self.factory = factory
        let mapView = MapView(appleMusicService: appleMusicService, locationController: locationController)
        super.init(mainView: mapView)
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
        setupMapReactiveButton()
        setupMapLocationButton()
        setupLocationManager()
        setupGestures()
        setupMapViewDelegate()
        registerMapPlacementViews()
    }
    override func viewDidLayoutSubviews() {
        mainView.setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isLocationOn = locationController.isLocationOn
        guard let location = locationController.location?.coordinate else { return }
        updateOverlay(location: location)
        
        
//        Task {
//            mainView.displayedPlacements = await AppData.shared.loadMusics()
//        }

    }
    var cancellable: Cancellable?
    override func viewDidAppear(_ animated: Bool) {
        Task {
            mainView.displayedPlacements = await AppData.shared.loadMusics()
            await mainView.allPlacements.append(contentsOf: AppData.shared.loadMusics())
        }
        if AppData.shared.currentStreaming == .appleMusic {
            SceneDelegate.appContainer.updateStreaming()
            mainView.currentStreaming = SceneDelegate.appContainer.currentStreaming
        } else {
            mainView.currentStreaming = SceneDelegate.appContainer.currentStreaming
        }
//        cancellable = SystemMusicPlayer.shared.state.objectWillChange.sink(receiveValue: { state in
//            let musicState = SystemMusicPlayer.shared.state.playbackStatus
//            let music1 = SystemMusicPlayer.shared.queue.currentEntry?.item?.id
//            print(music1, "<------")
//        })
    }
    
    func setupMapReactiveButton() {
        mainView.reactiveButton!.addTarget(self, action: #selector(handleAddSongButtonAction), for: .touchUpInside)
        //mainView.currentSongView?.addSongButton.addTarget(<#T##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        //mainView.currentSongView!.addSongButton.addTarget(self, action: #selector(handleAddSongButtonAction), for: .touchUpInside)
    }
    func setupMapLocationButton() {
        mainView.locationButton.addTarget(self, action: #selector(handleLocationButtonAction), for: .touchUpInside)
    }
    
    /// Function that changes the button state and return it to the `reactiveButton`.
    func updateReactiveButton() {
        mainView.reactiveButton!.setButtonState(state: .addCurrentSong)
        //mainView.currentSongView!.addSongButton.setButtonState(state: .addCurrentSong)
    }
    
    func updateLocationButton() {
        guard isLocationOn,
              let userLocation = locationController.location
        else { mainView.locationButton.setButtonState(state: .userNotFocus); return }
        
        let centerCoordinate = CLLocation(latitude: mainView.region.center.latitude, longitude: mainView.region.center.longitude)
        
        let distanceFromUserToMapCenterRegion = userLocation.distance(from: centerCoordinate)
        
        if distanceFromUserToMapCenterRegion > 5 {
            mainView.locationButton.setButtonState(state: .userNotFocus)
            return
        } 
    }
    /// Sets the object that changes the properties by the state.
    @objc func handleAddSongButtonAction() {
        print("alou", mainView.currentStreaming)
        mainView.addPlacement()
    }

    @objc func handleLocationButtonAction() {
        switch mainView.locationButton.state {
        case .userNotFocus:
            isLocationOn ? goToMyLocation() : requestLocationAuthorization()
        default:
            break
        }
    }
    
    private func registerMapPlacementViews() {
        mainView.register(MusicPlacementView.self, forAnnotationViewWithReuseIdentifier: MusicPlacementView.reuseIdentifier)
        mainView.register(ClusterPlacementView.self, forAnnotationViewWithReuseIdentifier: ClusterPlacementView.reuseIdentifier)
    }
    /// Set the action button that redirect the user
    /// camera to the user location at the map.
    func goToMyLocation() {
        guard let userLocation = locationController.location else { return }
        isTrackingUserModeEnabled = true
        mainView.setCenter(userLocation.coordinate, animated: true)
//        updateAnnotations()
    }
    

    func requestLocationAuthorization() {
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
