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
    
    typealias Factory = MusicServiceFactory
    
    var factory: Factory
//    var appleMusicService: AppleMusicService = AppleMusicService()
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
    
    var addSameMusic: UIAlertController = {
        let title = "Essa música já foi adicionada"
        let message = "Você já adicionou essa música em uma localidade próxima."
        let preferredStyle = UIAlertController.Style.actionSheet
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        return alert
    }()
    
    var displayedPlacements: [MKAnnotation]? {
        willSet {
            if let currentPlacements = displayedPlacements {
                print("removendo", currentPlacements.count)
                mainView.removeAnnotations(currentPlacements)
                print("removendo...")
            }
        }
        didSet {
            if let newPlacements = displayedPlacements {
//                let previousCount: Int = oldValue?.count ?? 0
//                let newPlacement = Array(newPlacements.suffix(newPlacements.count - previousCount))
//                print("Vai mostrar ", newPlacement.count - previousCount)
                print("mostrando", newPlacements.count)
                mainView.addAnnotations(newPlacements)
//                                AppData.shared.update(musics: newPlacements)
                print("mostrando...")
            }
        }
    }
    
    static var allPlacements: [MKAnnotation] = []
    static var allMusicPlacements: [MusicPlacementModel] = allPlacements.compactMap{$0 as? MusicPlacementModel}

    private func addAlertAction() {
        addSameMusic.addAction(UIAlertAction(title: "Ok!", style: .default, handler: nil))
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
        let mapView = MapView(locationController: locationController)
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
        setupMapLocationButton()
        setupLocationManager()
        setupGestures()
        setupMapViewDelegate()
        registerMapPlacementViews()
        addAlertAction()
    }
    override func viewDidLayoutSubviews() {
        mainView.setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isLocationOn = locationController.isLocationOn
        guard let location = locationController.location?.coordinate else { return }
        updateOverlay(location: location)
    }
    override func viewDidAppear(_ animated: Bool) {
        Task {
            displayedPlacements = await AppData.shared.loadMusics()
            await MapViewController.allPlacements.append(contentsOf: AppData.shared.loadMusics())
        }
        SceneDelegate.appContainer.updateStreaming()
        mainView.currentStreaming = SceneDelegate.appContainer.currentStreaming
        
        mainView.currentSongView = AddCurrentSongView(width: UIScreen.main.bounds.width * 0.9, height: 81, mapView: mainView, currentStreaming: mainView.currentStreaming)
        mainView.setupCurrentSongView()
        setupMapReactiveButton()
        
        mainView.currentStreaming?.delegate = mainView


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
        addPlacement()
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
//        mainView.setCenter(CLLocationCoordinate2D(latitude: 40.748594910689874, longitude: -73.9856644020802), animated: true)
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
    
    enum PlacementStatus {
        case hasSameMusic
        case canAdd
    }
    /// Check if user can add annotation.
    /// - Parameter userLocation: Current user location.
    /// - Returns: Returns if userLocation variable is not being used in any other annotation.
    private func canAddPlacement(_ userLocation: CLLocationCoordinate2D) -> PlacementStatus {
        var placementStatus: PlacementStatus = .canAdd
        
        if !MapViewController.allPlacements.isEmpty {
            
            for annotation in MapViewController.allPlacements{
                
                let distanceFromUserToAnnotation = locationController.calculateDistance(userLocation: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude), annotationCoordinate: annotation.coordinate)
                
                //TODO: determinar e calcular distancia para que as músicas sejam consideradas no mesmo local
                if distanceFromUserToAnnotation < 250 &&  annotation.title == mainView.currentStreaming?.currentTitle {
                    placementStatus = .hasSameMusic
                }
            }
        }
        return placementStatus
    }
    
    public func createPlacements (location: CLLocationCoordinate2D, music: MusicProtocol) async -> [MKAnnotation] {
        print("music name -------", music.currentTitle)
        await music.getCurrentPicture()
        let placement = MusicPlacementModel(latitude: location.latitude, longitude: location.longitude, title: music.currentTitle, artist: music.currentArtist, musicData: music.currentPhotoData)
        MapViewController.allPlacements.append(placement)
//        print("all", allPlacements.count)
        print("foto-------", music.currentPhotoData.debugDescription)
        AppData.shared.update(musics: MapViewController.allPlacements)
        
        return await AppData.shared.loadMusics()
    }
    
    func addPlacement() {
        guard let userLocation2 = locationController.location?.coordinate else { return }
        var userLocation = userLocation2
//        CLLocationCoordinate2D(latitude: 40.748594910689874, longitude: -73.9856644020802)
//        userLocation.latitude += CLLocationDegrees.random(in: -0.02...0.02)
//        userLocation.longitude =
        userLocation.latitude += CLLocationDegrees.random(in: -0.02...0.02)
        userLocation.longitude += CLLocationDegrees.random(in: -0.02...0.02)
        
        locationController.updateLastLocation()
        
        switch canAddPlacement(userLocation) {
        case .canAdd:
            Task {
                if mainView.currentStreaming != nil{
                    let placements = await createPlacements(location: userLocation, music: mainView.currentStreaming!)
                    
                    displayedPlacements = placements
                }
                else{
                    print("NULOO")
                }
            }
        case .hasSameMusic:
            present(addSameMusic, animated: true, completion: nil)
            
            // TODO: adiciona música na view de playlist
            // TODO: checa se tem essa música na view de playlist
            // TODO: pop-up avisando que tem a mesma música nesta playlist
        }
    }
}
