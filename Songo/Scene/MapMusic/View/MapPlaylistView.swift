//
//  MapPlaylistView.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import UIKit

class MapPlaylistView: UIView {
    
    public let deleteButton = UIButton()
    
    public let actionSheetController: UIAlertController = UIAlertController(title: "", message: NSLocalizedString("Tem certeza que deseja apagar sua publicação?", comment: "AnnotationDetailView: Sheet alert description"), preferredStyle: .actionSheet)
    
    private var clusterAlbumPicture = UIScreen.main.bounds.width * 0.65
    
    private func setupView() {
        backgroundColor = .fundo
    }
}
