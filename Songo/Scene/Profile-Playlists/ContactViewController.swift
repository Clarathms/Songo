//
//  ContactViewController.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 06/02/23.
//

import Foundation
import UIKit
import SwiftUI

class ContactViewController: UIViewController {
    let contentView = UIHostingController(rootView: ContactUsView())

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
