//
//  BaseViewController.swift
//  Songo
//
//  Created by Amanda Melo on 23/01/23.
//

import Foundation
import UIKit

/// A BaseViewController class that is used to implement new ViewControllers. It is based on a view that is received at init that is the main container of other subviews.
class BaseViewController<V: UIView>: UIViewController {
    
    var mainView: V
    
    init(mainView: V) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
}
