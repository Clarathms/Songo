//
//  PlaylistViewController.swift
//  Songo
//
//  Created by Amanda Melo on 06/02/23.
//


import Foundation
import UIKit
import SwiftUI
import MapKit

class MapPlaylistController: BaseViewController<MapPlaylistView> {
    var coverView: UIImage = UIImage ()
    var titleList: [String] = []
//    var albumList: [String]
    var artistList: [String] = []
    var pictureList: [UIImage] = []
    var annotations: [MKAnnotation] = []
    // var listStyle: ReminderListStyle = .today
    var listStyle: ReminderListStyle = .today
    var cluster: MKClusterAnnotation

    // var collectionView: UICollectionViewController
    let listStyleSegmentedControl = UISegmentedControl(items: [
        ReminderListStyle.today.name, ReminderListStyle.future.name, ReminderListStyle.all.name
    ])
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>

    var dataSource: DataSource!
    
    init(cluster: MKClusterAnnotation) {
        self.cluster = cluster
        annotations = cluster.memberAnnotations
        
        for annotation in annotations {
            if let isModel = annotation as? MusicPlacementModel {
                titleList.append(isModel.title!)
                artistList.append(isModel.artist!)
                pictureList.append(isModel.musicPicture ?? UIImage())
            }
        }
        if let isModel = annotations.first as? MusicPlacementModel {
            coverView = isModel.musicPicture ?? UIImage()
        }

        
        let mapPlaylistView = MapPlaylistView()
        super.init(mainView: mapPlaylistView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()
        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
//        listStyleSegmentedControl.addTarget(
//            self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        navigationItem.titleView = listStyleSegmentedControl

        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
 
        
        
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
    

   
    
}
enum ReminderListStyle: Int {
    case today
    case future
    case all

    var name: String {
        switch self {
        case .today:
            return NSLocalizedString("Today", comment: "Today style name")
        case .future:
            return NSLocalizedString("Future", comment: "Future style name")
        case .all:
            return NSLocalizedString("All", comment: "All style name")
        }
    }

//    func shouldInclude(date: Date) -> Bool {
//        let isInToday = Locale.current.calendar.isDateInToday(date)
//        switch self {
//        case .today:
//            return isInToday
//        case .future:
//            return (date > Date.now) && !isInToday
//        case .all:
//            return true
//        }
//    }
}
struct Reminder {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
}

