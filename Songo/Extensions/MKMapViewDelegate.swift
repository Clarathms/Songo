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
        if let clusterPlacement = view.annotation as? ClusterPlacementView, clusterPlacement.isKind(of: MusicPlacementModel.self) {
            let pin = view.annotation
            
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var placementView: MKAnnotationView?
        
        guard let placement = annotation as? MusicPlacementModel else { return nil }
        placementView = setupMusicPlacementView(for: placement, on: mapView)
        
        if let musicPlacementView = placementView as? MusicPlacementView {
            if shouldCluster {
                musicPlacementView.clusteringIdentifier = "music"
            } else {
                musicPlacementView.clusteringIdentifier = nil
            }
        }
        return placementView
    }
    
    @objc func rightButtonClick() {
        let playlistNavController = MapPlaylistViewController()
        playlistNavController.modalPresentationStyle = .popover
        let presentationController = playlistNavController.popoverPresentationController
        presentationController?.permittedArrowDirections = .any

        present(playlistNavController, animated: true, completion: nil)
    }
    
    private func setupMusicPlacementView (for annotation: MusicPlacementModel, on mapView: MKMapView) -> MKAnnotationView {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: MusicPlacementView.reuseIdentifier, for: annotation)
        view.canShowCallout = true
        let rightButton = UIButton(type: .detailDisclosure)
        view.detailCalloutAccessoryView = rightButton
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return view
    }
    
    private func setupClusterPlacementView (for annotation: MusicPlaylistModel, on mapView: MKMapView) -> MKAnnotationView {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: ClusterPlacementView.reuseIdentifier, for: annotation)
//        let rightButton = UIButton(type: .detailDisclosure)
        view.canShowCallout = true
//        view.detailCalloutAccessoryView = rightButton
//        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return view
    }
}
