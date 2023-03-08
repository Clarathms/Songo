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

class MapPlaylistController: BaseViewController<MapPlaylistView> {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    var dataSource: DataSource!
    
    struct Cells {
        static let titleCell = "contactCell"
        static let styleCell = "styleCell"

    }
    var coverView: UIImage = UIImage ()
    
    var titleList: Array<String> = []
    var titleListS: Set<MusicPlacementModel> = []
    var artistList: [String] = []
    var pictureList: [UIImage] = []
    //    var albumList: [String]
    
    var finalAnnotations: [MKAnnotation] = []
    var cluster: MKClusterAnnotation
    var musicsTableView = UITableView()
    var toCoverView: UIImageView?
    var albumPicture: UIImage?
    
    var primeiraMusica: String?
    weak var mapView: MKMapView?
    var titleString: String?

    
//    var toCoverView: UIImageView = {
//        toCoverView.layer.cornerRadius = 10
//        toCoverView.clipsToBounds = true
//        toCoverView.image = coverView
//
//        return toCoverView
//    }()

    private var tableView: UITableView = {

        let tableView = UITableView(frame: .zero, style: .plain)
        //tableView.backgroundColor = .fundo
        tableView.separatorColor = .fundoSecundario
        tableView.separatorInset = .init(top: 200, left: 80, bottom: 200, right: 0)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 70
        tableView.backgroundColor = .fundoPlaylist
        print("entrei na table view")
        tableView.register(StyleCell.self, forCellReuseIdentifier: Cells.styleCell)
                
        return tableView

    }()
    
    
    init(cluster: MKClusterAnnotation, mapView: MKMapView) {
        self.cluster = cluster
        self.mapView = mapView
        for annotation in cluster.memberAnnotations {
            if !finalAnnotations.contains(where: { $0.title == annotation.title}) {
                finalAnnotations.append(annotation)
            }
        }
        
        for finalAnnotation in finalAnnotations {
            
            if let isModel = finalAnnotation as? MusicPlacementModel {
                titleList.append(isModel.title!)
                artistList.append(isModel.artist!)
                pictureList.append(isModel.musicPicture ?? UIImage())
                

                self.primeiraMusica = titleList[0]
                self.albumPicture = pictureList[0]
            }
        } 
        print(pictureList.count, "------fotos")
        if let isModel = finalAnnotations.first as? MusicPlacementModel {
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
      //  getCount()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        


        addImgCapa()
     //   addImageLabels()
       // view.addSubview(self.toCoverView!)
        view.addSubview(tableView)
        setTableViewConstrains()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
   
    func addImgCapa() {
        self.albumPicture = pictureList[0]

//
//        self.toCoverView!.layer.cornerRadius = 10
//        self.toCoverView!.clipsToBounds = true
//        self.toCoverView!.image = albumPicture
//
//        self.view.bringSubviewToFront( self.toCoverView!)

        let image = self.albumPicture
        let imageView = UIImageView(image: image!)
      //  imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: UIScreen.main.bounds.midX*0.45, y: UIScreen.main.bounds.midY*0.2, width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.width/1.8)
        self.view.addSubview(imageView)
        //Imageview on Top of View
        self.view.bringSubviewToFront(imageView)

    }
    
    func addImageLabels() {
    
        var titleLabel: UILabel?
     //   self.primeiraMusica = titleString[0]
        
        titleLabel?.text = self.primeiraMusica
        titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.textColor = .white
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel?.frame = CGRect(x: UIScreen.main.bounds.midX*0.45, y: UIScreen.main.bounds.midY, width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.width/1.8)
        
        self.view.addSubview(titleLabel!)
        self.view.bringSubviewToFront(titleLabel!)

        
    }
    
    func setTableViewConstrains() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        //    self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
           // self.tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 2)
            self.tableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                   constant: 8)
        ])
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
    
//    func getCount (){
//        let musicCount = self.annotations.count
//        for _ in 1...musicCount {
//            print("Print da Anottation ------")
//            print(annotations)
//            musicsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Cells.styleCell)
//        }
//    }
   
    
}

extension MapPlaylistController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalAnnotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.styleCell, for: indexPath) as! StyleCell

        cell.onTap = {
            self.present(cell.deleteMusicAlert, animated: true, completion: nil)
        }
        
        
        cell.onDelete = {
            
            let elem = self.finalAnnotations[indexPath.row]
            MapViewController.allPlacements = MapViewController.allPlacements.filter { annotation in
                guard let songModel = annotation as? MusicPlacementModel else {return false}
                guard let elemModel = elem as? MusicPlacementModel else {return false}
                return songModel.id != elemModel.id
            }
            self.mapView?.removeAnnotation(elem)
            self.finalAnnotations.removeAll(where: {$0.title == elem.title})
            
            AppData.shared.update(musics: MapViewController.allPlacements)
            tableView.reloadData()
        }
        
        cell.setup(from: finalAnnotations[indexPath.row])
        
        return cell
    }
}
extension MapPlaylistController: UITableViewDelegate {
    
}

// A B C D E
// C D E
