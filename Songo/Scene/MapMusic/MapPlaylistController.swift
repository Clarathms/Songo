//
//  PlaylistViewController.swift
//  Songo
//
//  Created by Amanda Melo on 06/02/23.
//


//         MapPlaylistController.mapView = mainView
// no map view controller
// Pegar table view (video andrew)

import Foundation
import UIKit
import SwiftUI

class MapPlaylistController: BaseViewController<MapPlaylistView>,UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        // define a parte de info (Nome,etc)
        cell.textLabel?.text = musicData![indexPath.row].title as! String
        print("BBBBBB")
        print(cell)
        return cell
    }
    
    //    var coverView: UIImage? = appleMusicController.currentPicture
    // var listStyle: ReminderListStyle = .today
  //  var listStyle: ReminderListStyle = .today
    var musicData = MapPlaylistController.mapView?.allPlacements
    static var mapView: MapView?
    var musicsTableView = UITableView()


    // var collectionView: UICollectionViewController
//    let listStyleSegmentedControl = UISegmentedControl(items: [
//        ReminderListStyle.today.name, ReminderListStyle.future.name, ReminderListStyle.all.name
//    ])
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>

    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()
//        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
////        listStyleSegmentedControl.addTarget(
////            self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
//        navigationItem.titleView = listStyleSegmentedControl

//        if #available(iOS 16, *) {
//            navigationItem.style = .navigator
//        }
 


        
        getCount()
        musicsTableView.delegate = self
        musicsTableView.dataSource = self
        musicsTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        let colorBottom = UIColor(red: 0.07450980693101883, green: 0.6941176652908325, blue: 0.6431372761726379, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func getCount (){
        var musicCount = self.musicData!.count
       
        for i in 1...musicCount {
            print("Print da Anottation \(i) ------")
            dump(MapPlaylistController.mapView?.allPlacements)
            musicsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        }
    }
   
    
}
//enum ReminderListStyle: Int {
//    case today
//    case future
//    case all
//
//    var name: String {
//        switch self {
//        case .today:
//            return NSLocalizedString("Today", comment: "Today style name")
//        case .future:
//            return NSLocalizedString("Future", comment: "Future style name")
//        case .all:
//            return NSLocalizedString("All", comment: "All style name")
//        }
//    }

//}
//struct Reminder {
//    var title: String
//    var dueDate: Date
//    var notes: String? = nil
//    var isComplete: Bool = false
//}
//
