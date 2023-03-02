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
import Combine
import MusicKit

/// The visualization of the map.
class MapView: MKMapView  {
    
//    lazy var musicTitle = currentStreaming?.currentTitle {
//
//        didSet{
//            self.musicTitle = currentStreaming?.currentTitle
//
//       }
//    }
   static var musicTitle: String?
   static var musicArtist: String?
   static var musicAlbum: String?
   static var musicPhotoData: Data?

    static var musicPhotoString: String?
//    lazy var musicTitle: String? = { currentStreaming?.currentTitle }()
//    lazy var musbicArtist: String? = { currentStreaming?.currentArtist }()
//    lazy var musicAlbum: String? = { currentStreaming?.currentAlbum}()
    //MARK: - Properties
    var currentSongView: AddCurrentSongView?
    //var reactiveButton = MapReactiveButton()
    
    var reactiveButton: MapReactiveButton?
    
    var isLocationOn: Bool {
        locationController?.isLocationOn ?? false
    }
    var locationButton = MapLocationButton()

    weak var locationController: LocationController?
    var currentStreaming: MusicProtocol?

    //MARK: - Initializers
    init(locationController: LocationController) {


//        self.currentStreaming = currentStreaming
        self.locationController = locationController
        
        super.init(frame: .zero)
        
        
      
//        self.currentSongView = AddCurrentSongView(width: UIScreen.main.bounds.width * 0.9, height: 81, mapView: self)
        //        self.reactiveButton = MapReactiveButton(x: Float(self.bounds.maxX/1.5), y: Float(self.bounds.maxY/6), width: Float(self.bounds.size.width * 0.15), height: Float(self.bounds.size.height * 0.5), mapView: self)
        //self.reactiveButton = MapReactiveButton(x: Float(UIScreen.main.bounds.maxX/3.5), y: Float(UIScreen.main.bounds.midY/10), width:Float(UIScreen.main.bounds.width * 0.2), height: 70)
        self.reactiveButton = MapReactiveButton(x: Float(UIScreen.main.bounds.width/1.2), y: Float(UIScreen.main.bounds.height/1.22), width:Float(UIScreen.main.bounds.width/9), height: Float(UIScreen.main.bounds.width/9))
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the `MapView` settings, `reactiveButton` and set the status of the user location with `showsUserLocation`.
    func setupMapView() {
        
        showsUserLocation = (isLocationOn ? true : false)
        locationButton.layer.masksToBounds = true
        locationButton.layer.cornerRadius = locationButton.layer.frame.height/2
        addSubview(locationButton)
        mapType = .mutedStandard
        setupLocationButtonConstraints()
        showsBuildings = false

    }
    func setupCurrentSongView() {
        addSubview(currentSongView!)
        addSubview(reactiveButton!)
        setupReactiveButtonConstraints()
        currentSongView?.setupCurrentSongview()
    }
    
    /// Setup the `ReactiveButton`constraints.
    func setupReactiveButtonConstraints() {
        currentSongView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentSongView!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            //   currentSongView.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentSongView!.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            currentSongView!.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
    func setupLocationButtonConstraints() {
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -190),
            locationButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width ),
            locationButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 150),
            
        ])
    }
    
    /// Set the center of the camera to the user`s location.
    /// - Parameter userLocation: the location of the user given by the LocationController.
    func setRegionToUserCurrentLocation(userLocation: CLLocation) {
        setCenter(userLocation.coordinate, animated: true)
//        setCenter(CLLocationCoordinate2D(latitude: 40.748594910689874, longitude: -73.9856644020802), animated: true)
    }
    /// Set the limited zoom region.
    /// - Parameter userLocation: the location of the user given by the LocationController.
    func setRegionToUserCurrentLocationWithZoomLimits(userLocation: CLLocation) {
        let region = MKCoordinateRegion.init(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        setRegion(region, animated: true)
//        let region = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: 40.748594910689874, longitude: -73.9856644020802), latitudinalMeters: 1000, longitudinalMeters: 1000)
//        setRegion(region, animated: true)
    }
    
    //MARK: - Annotations
    

    
    
    var isLoading: Bool = false

}

extension MapView: MusicProtocolDelegate {
    
    func didGet(song: Song) {
        print("Recebi musica do apple music")
//        DispatchQueue.main.async {
//            Task {
//                await self.currentStreaming?.getCurrentPicture()
//                MapView.musicPhotoData = self.currentStreaming?.currentPhotoData
//                print(MapView.musicPhotoData?.count, "tem coisa")
//            }
//        }
        MapView.musicTitle = currentStreaming?.currentTitle
        MapView.musicArtist = currentStreaming?.currentArtist
        MapView.musicAlbum = currentStreaming?.currentAlbum
//        MapView.musicPhotoData = currentStreaming?.currentPhotoData
        
        print(MapView.musicTitle!)
        print(MapView.musicArtist!)
        print(MapView.musicAlbum!)
    }
    
    func didGet(song: SPTAppRemoteTrack) {
        print("Recebi musica do Spotify")
//        if isLoading {return}
//        isLoading = true
//        DispatchQueue.main.async {
//            Task { [weak self] in
//                guard let self = self else { return }
//                
//                await self.currentStreaming?.getCurrentPicture()
//                MapView.musicPhotoData = self.currentStreaming?.currentPhotoData
//                print(MapView.musicPhotoData?.count, "tem coisa")
//                self.isLoading = false
//            }
//        }
//        DispatchQueue.main.async {
//            Task {
//                await self.currentStreaming?.getCurrentPicture()
//                MapView.musicPhotoData = self.currentStreaming?.currentPhotoData
//            }
//        }
        MapView.musicTitle = currentStreaming?.currentTitle
        MapView.musicArtist = currentStreaming?.currentArtist
        MapView.musicAlbum = currentStreaming?.currentAlbum
        
        
        print(MapView.musicTitle!, "****** A")
        print(MapView.musicArtist!)
        print(MapView.musicAlbum!)
        print(MapView.musicPhotoData?.count)

        
    }
}
