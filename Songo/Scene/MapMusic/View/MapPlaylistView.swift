//
//  MapPlaylistView.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import UIKit

class MapPlaylistView: UIView {
    
    let cellReuseIdentifier = "item"
    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSizeMake(30, 40)

//        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        view.register(MusicPlaylistCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
//
//        return view
//    }()
    
    public let deleteButton = UIButton()
    
    public let actionSheetController: UIAlertController = UIAlertController(title: "", message: NSLocalizedString("Tem certeza que deseja apagar sua publicação?", comment: "AnnotationDetailView: Sheet alert description"), preferredStyle: .actionSheet)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.addSubview(collectionView)
//
//        let margins = self.layoutMarginsGuide
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 2).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 2).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
//
//        self.backgroundColor = collectionView.backgroundColor

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .fundo
    }
}
