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
    }
    
    func setupMapViewDelegate() {
        mainView.delegate = self
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        updateReactiveButton()
    }
//    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
//        print(memberAnnotations.count)
//        if let annotationModel = memberAnnotations.first as? MusicPlacementModel {
//        }
//        return MKClusterAnnotation(memberAnnotations: memberAnnotations)
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        guard let annotation = annotation as? MusicPlacementModel else {
            return nil
        }
        annotationView = setupSongPlacementView(for: annotation, on: mapView)
        
        return annotationView
    }
    
    @objc func rightButtonClick() {
        let playlistNavController = MapPlaylistViewController()
        playlistNavController.modalPresentationStyle = .popover
        let presentationController = playlistNavController.popoverPresentationController
        presentationController?.permittedArrowDirections = .any

        present(playlistNavController, animated: true, completion: nil)
    }
    
    private func setupSongPlacementView (for annotation: MusicPlacementModel, on mapView: MKMapView) -> MKAnnotationView {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: MusicPlacementView.reuseIdentifier, for: annotation)
        view.canShowCallout = true
        let rightButton = UIButton(type: .detailDisclosure)
        view.detailCalloutAccessoryView = rightButton
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return view
    }
}
