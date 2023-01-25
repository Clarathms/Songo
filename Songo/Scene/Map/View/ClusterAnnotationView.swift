//
//  AglomerateView.swift
//  Songo
//
//  Created by Amanda Melo on 25/01/23.
//

import Foundation
import MapKit

class ClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -20) // Offset center point to animate better with marker annotations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
