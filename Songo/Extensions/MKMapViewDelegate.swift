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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        guard let annotation = annotation as? SongPlacementModel else {
            print("Cant convert annotation")
            return nil
        }
        annotationView = setupSongPlacementView(for: annotation, on: mapView)
        
        return annotationView
       
    }
    
    private func setupSongPlacementView (for annotation: SongPlacementModel, on mapView: MKMapView) -> MKAnnotationView {
        return mapView.dequeueReusableAnnotationView(withIdentifier: SongPlacementView.reuseIdentifier, for: annotation)
    }

    
}
