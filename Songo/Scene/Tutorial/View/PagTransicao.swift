//
//  PagTransicao.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 30/01/23.
//

import Foundation
import UIKit

class PagTransicao: UIViewController {
   
    var gameTimer: Timer! //Timer object

    override func viewDidLoad() {

        super.viewDidLoad()

        gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timeaction), userInfo: nil, repeats: true)

    }

    //Timer action
    @objc func timeaction(){

        //code for move next VC
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                self.navigationController?.pushViewController(secondVC, animated: true)
        gameTimer.invalidate()//after that timer invalid

    }
    
}
