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
import MapKit

class MapPlaylistController: BaseViewController<MapPlaylistView>,UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        // define a parte de info (Nome,etc)
        cell.textLabel?.text = (annotations[indexPath.row].title ?? " -- ")! as String
        return cell
    }
    
    //    var coverView: UIImage? = appleMusicController.currentPicture
    var coverView: UIImage = UIImage ()
    var titleList: [String] = []
//    var albumList: [String]
    var artistList: [String] = []
    var pictureList: [UIImage] = []
    var annotations: [MKAnnotation] = []
    // var listStyle: ReminderListStyle = .today
    var cluster: MKClusterAnnotation
  //  var listStyle: ReminderListStyle = .today
//    var musicData = MapPlaylistController.mapView?.allPlacements
//    static var mapView: MapView?
    var musicsTableView = UITableView()

    
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
        setGradientBackground()

        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()


        
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
        let musicCount = self.annotations.count
       
        for _ in 1...musicCount {
            print("Print da Anottation ------")
            print(annotations)
            musicsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        }
    }
   
    
}
