//
//  MKMapViewDelegate.swift
//  Songo
//
//  Created by Amanda Melo on 26/01/23.
//

//  MKMapViewDelegate.swift
//  Songo
//
//  Created by Amanda Melo on 26/01/23.
//

import Foundation
import MapKit
import UIKit

extension MapViewController: MKMapViewDelegate {
        
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        updateReactiveButton()
        //self.mapView.currentSongView?.addSongButton.updateReactiveButton()
        updateLocationButton()
    }
    
    func setupMapViewDelegate() {
        mainView.delegate = self
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        updateReactiveButton()
        //self.mapView.currentSongView?.addSongButton.updateReactiveButton()
        updateLocationButton()
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation)
        if let clusterPlacement = view.annotation as? MKClusterAnnotation, clusterPlacement.isKind(of: MKClusterAnnotation.self) {
            let pin = view.annotation
            let playlistViewController = MapPlaylistController(cluster: clusterPlacement)
            print("apertei")
            // Create half-modal
            playlistViewController.modalPresentationStyle = .custom
//            playlistViewController.transitioningDelegate = self
            present(playlistViewController, animated: true)
            
            
            
            
            
            //mapView.deselectAnnotation(pin, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var placementView: MKAnnotationView?
        
        if let placement = annotation as? MusicPlacementModel {
            placementView = setupMusicPlacementView(for: placement, on: mapView)
            
            if let musicPlacementView = placementView as? MusicPlacementView {
                if shouldCluster {
                    musicPlacementView.clusteringIdentifier = "music"
                } else {
                    musicPlacementView.clusteringIdentifier = nil
                }
            }
        }
        else if let clusterPlacement = annotation as? MKClusterAnnotation {
            placementView = setupClusterPlacementView(for: clusterPlacement, on: mapView)
            
            if let musicClusterView = placementView as? ClusterPlacementView {
                
                return musicClusterView
            }
        }
        
        return placementView
    }
    
//    @objc func rightButtonClick() {
//        let playlistNavController = MapPlaylistController(cluster: <#T##MKClusterAnnotation#> )
//        playlistNavController.modalPresentationStyle = .popover
//        let presentationController = playlistNavController.popoverPresentationController
//        presentationController?.permittedArrowDirections = .any
//
//        present(playlistNavController, animated: true, completion: nil)
//    }
//
    private func setupMusicPlacementView (for annotation: MusicPlacementModel, on mapView: MKMapView) -> MKAnnotationView {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: MusicPlacementView.reuseIdentifier, for: annotation)
//        view.canShowCallout = true
//        let rightButton = UIButton(type: .detailDisclosure)
//        view.detailCalloutAccessoryView = rightButton
//        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return view
    }
    
    private func setupClusterPlacementView (for annotation: MKClusterAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: ClusterPlacementView.reuseIdentifier, for: annotation)
//        let rightButton = UIButton(type: .detailDisclosure)
//        view.canShowCallout = true
//        view.detailCalloutAccessoryView = rightButton
//        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return view
    }
}
