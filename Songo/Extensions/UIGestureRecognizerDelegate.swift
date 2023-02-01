//
//  UIGestureRecognizerDelegate.swift
//  Songo
//
//  Created by Amanda Melo on 01/02/23.
//

import Foundation
import UIKit

extension MapViewController: UIGestureRecognizerDelegate {
    
    func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap(_:)))
        panGesture.delegate = self
        mainView.addGestureRecognizer(panGesture)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            isTrackingUserModeEnabled = false
        }
    }

}
