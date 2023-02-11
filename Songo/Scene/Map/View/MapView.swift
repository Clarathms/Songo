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
    var isLocationOn: Bool {
        locationController?.isLocationOn ?? false
    }
    var locationButton = MapLocationButton()
    weak var appleMusicController: AppleMusicController?
    weak var locationController: LocationController?
    
    var displayedPlacements: [MKAnnotation]? {
        willSet {
            if let currentPlacements = displayedPlacements {
                removeAnnotations(currentPlacements)
                print("removendo...")
            }
        }
        didSet {
            if let newPlacements = displayedPlacements {
                addAnnotations(newPlacements)
//                AppData.shared.update(musics: newPlacements)
                print("mostrando...")
            }
        }
    }
    
    var allPlacements: [MKAnnotation] = []

    //MARK: - Initializers
    init(appleMusicController: AppleMusicController, locationController: LocationController) {
        self.appleMusicController = appleMusicController
        self.locationController = locationController
        super.init(frame: .zero)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the `MapView` settings, `reactiveButton` and set the status of the user location with `showsUserLocation`.
    func setupMapView() {
            
        showsUserLocation = (isLocationOn ? true : false)
        addSubview(reactiveButton)
     //   addSubview(locationButton)
        mapType = .mutedStandard
        setupReactiveButtonConstraints()
        showsBuildings = false
    }
    
    /// Setup the `ReactiveButton`constraints.
    func setupReactiveButtonConstraints() {
        reactiveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reactiveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            reactiveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reactiveButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            reactiveButton.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
    func setupLocationButtonConstraints() {
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reactiveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            reactiveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reactiveButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            reactiveButton.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
    
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
    
    //MARK: - Annotations
    
    enum PlacementStatus {
        case isEmpty
        case hasMusic
        case hasSameMusic
    }
    
    /// Check if user can add annotation.
    /// - Parameter userLocation: Current user location.
    /// - Returns: Returns if userLocation variable is not being used in any other annotation.
    private func canAddPlacement(_ userLocation: CLLocationCoordinate2D) -> PlacementStatus {
        
        guard let appleMusicController = appleMusicController else { fatalError("No appleMusicController at \(#function)") }
        Task {
            await appleMusicController.getCurrentMusic()
        }
        
        if !allPlacements.isEmpty {
            for annotations in allPlacements{
                //TODO: determinar e calcular distancia para que as músicas sejam consideradas no mesmo local
                if annotations.coordinate == userLocation {
                    if annotations.title == appleMusicController.currentTitle {
                        return .hasSameMusic
                    }
                    return .hasMusic
                }
            }
        }
        return .isEmpty
    }
    
    public func createPlacement (location: CLLocationCoordinate2D, music: AppleMusicController) async -> [MKAnnotation] {

        let placement = MusicPlacementModel(latitude: location.latitude, longitude: location.longitude, title: music.currentTitle, musicURL: music.currentURLPicture, artist: music.currentArtist)
        await placement.getCurrentPicture()
        allPlacements.append(placement)
        AppData.shared.update(musics: allPlacements)
        
        return await AppData.shared.loadMusics()
    }
    
    func addPlacement() {
        
        guard let locationController = locationController,
        let appleMusicController = appleMusicController else { fatalError("No locationController or appleMusicController at \(#function)") }
        
        guard let userLocation = locationController.location?.coordinate else { return }
        locationController.updateLastLocation()
        
        switch canAddPlacement(userLocation) {
        case .isEmpty:
            Task {
                let placement = await createPlacement(location: userLocation, music: appleMusicController)
                
                displayedPlacements = placement
            }
        case .hasMusic:
            break
        case .hasSameMusic:
            break
        }

        // TODO: adiciona música na view de playlist
        // TODO: checa se tem essa música na view de playlist
        // TODO: pop-up avisando que tem a mesma música nesta playlist
    }
}
