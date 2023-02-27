//
//  PlaylistPresentationController.swift
//  Songo
//
//  Created by Amanda Melo on 27/02/23.
//

import Foundation
import UIKit

/// Custom presentation controller.
class PlaylistPresentationController: UIPresentationController {
    /// Reference to view controller that instanciated self object.
    public var sourceViewController: UIViewController?
    /// Reference to update panning.
    private var originalY: CGFloat = 0
    /// Amount of container view height the presented view should appear on. Beetween 0 and 1.
    private var relativeHeight: CGFloat = 0
    /// View that indicates draggable functionality.
    private var handleView = UIView()
    
    init(presented: UIViewController, presenting: UIViewController, source: UIViewController, relativeHeight: CGFloat){
        super.init(presentedViewController: presented, presenting: presenting)
        self.sourceViewController = source
        self.relativeHeight = relativeHeight
        presented.view.layer.cornerRadius = 20
        presented.view.clipsToBounds = true
        setupHandleView(in: presented.view)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        let height = bounds.height * relativeHeight
        return CGRect(x: 0, y: bounds.height - height, width: bounds.width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        UIView.animate(withDuration: 0.2) {
            self.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        containerView?.addGestureRecognizer(viewPan)
    }
    
    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.5) {
            self.containerView?.backgroundColor = .clear
        }
    }
    
    /// Updates view panning according to translation.
    /// - Parameter sender: Object to get translation from.
    @objc private func viewPanned(_ sender: UIPanGestureRecognizer) {
        let translate = sender.translation(in: self.presentedView)
        switch sender.state {
            case .began:
                originalY = presentedViewController.view.frame.origin.y
            case .changed:
                if translate.y > 0 {
                    presentedViewController.view.frame.origin.y = originalY + translate.y
                }
            case .ended:
                let presentedViewHeight = presentedViewController.view.frame.height
                let newY = presentedViewController.view.frame.origin.y
                if abs(originalY - newY) < presentedViewHeight * 0.25 {
                    setBackToOriginalPosition()
                } else {
                    self.presentingViewController.dismiss(animated: true)
                }
            default:
                break
        }
    }
    
    /// Restore original y value.
    private func setBackToOriginalPosition() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.presentedViewController.view.frame.origin.y = self.originalY
        })
    }
    
    /// Setup handleView style and constraints. Add it as a subview to another view.
    /// - Parameter view: View in which handleView will be added as subview.
    private func setupHandleView(in view: UIView){
        view.addSubview(handleView)
        
        handleView.backgroundColor = .white
        handleView.clipsToBounds = true
        handleView.layer.cornerRadius = 3.0
        
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        handleView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        handleView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 8).isActive = true
        handleView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
}
