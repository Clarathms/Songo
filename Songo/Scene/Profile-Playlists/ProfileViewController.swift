//
//  ProfileViewController.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 06/02/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    let message = UILabel(frame:.zero)
    let warningImage = UIImage(systemName: "exclamationmark.triangle.fill")
    let myImageView:UIImageView = UIImageView()
    
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .fundoSecundario
        
        setupImage()
        setupText()
        self.view = view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraint()
    }
    
    func setupText () {
        message.text = "Em Construção..."
        message.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        message.textColor = .white
        message.textAlignment = .center
        message.numberOfLines = 0
        message.font = UIFont(name:"Fira Sans", size: 30.0)
        message.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(message)
    }
    
    func setupImage () {
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = .zero
        myImageView.frame.size.height = .zero
        myImageView.tintColor = .white
        myImageView.center = self.view.center
        myImageView.image = warningImage
        view.addSubview(myImageView)
    }
    
    func addConstraint() {
        message.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //            myImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            //            myImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            //            myImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            //            myImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            //            message.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            message.heightAnchor.constraint(equalToConstant: 50),
            
            myImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            myImageView.heightAnchor.constraint(equalToConstant: 100),
            
            NSLayoutConstraint(item: self.myImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.myImageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.9, constant: 0),
            
            NSLayoutConstraint(item: self.message, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.2, constant: 0),
            NSLayoutConstraint(item: self.message, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
            
        ])
    }
}
