//
//  SwiftUIHostingVC.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 30/01/23.
//

import UIKit
import SwiftUI

class ViewControllerTutorial: UIViewController {
    
    let contentView = UIHostingController(rootView: AuthorizationView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView.view)
        addConstraint()
    }
    
    func addConstraint() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
