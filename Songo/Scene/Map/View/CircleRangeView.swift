//
//  CircleRangeVIew.swift
//  Songo
//
//  Created by Amanda Melo on 24/01/23.
//

import Foundation
import MapKit

/// Class that hold and init the Circle Max Range characteristics.
/// Muda as características da região ao redor da localização atual do mapa
class CircleRangeView: MKCircleRenderer {
    override init(circle: MKCircle) {
        super.init(circle: circle)
//        fillColor =
//        alpha = 0.4
//        strokeColor =
//        strokeColor?.withAlphaComponent(0.4)
        lineWidth = 7
    }
}
