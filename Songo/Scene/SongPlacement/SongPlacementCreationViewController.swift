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
//
//class SongPlacementController{
//
//    let mapView: MKMapView
//    let mainButton = SongButtonView()
//    private let songPlacement: SongPlacementModel?
//    private var mapViewController: UIViewController?
////    let locationController: LocationController
//    var allPlacements: [MKAnnotation] = []
//    private var displayedPlacements: [MKAnnotation]? {
//        willSet {
//            if let currentPlacements = displayedPlacements {
//                mapView.removeAnnotations(currentPlacements)
//            }
//        }
//        didSet {
//            if let newPlacements = displayedPlacements {
//                mapView.addAnnotations(newPlacements)
//            }
//        }
//    }
//
//    public func createPlacement(location: CLLocationCoordinate2D, music: AppleMusicController) {
//        let placement = SongPlacementModel(latitude: location.latitude, longitude: location.longitude)
//        placement.title = music.currentTitle
//        placement.imageName = music.currentPicture
//
//
////        var appendPlacement: [MKAnnotation] = allPlacements.append(placement)
//    }
//}
