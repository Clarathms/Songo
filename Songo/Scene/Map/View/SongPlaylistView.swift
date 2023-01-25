//
//  SongPlaylistView.swift
//  Songo
//
//  Created by Amanda Melo on 24/01/23.
//

import Foundation
import UIKit
import MapKit

class PlaylistAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
