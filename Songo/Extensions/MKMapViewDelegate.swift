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
    
    func setupMapViewDelegate() {
        mainView.delegate = self
    }
}
