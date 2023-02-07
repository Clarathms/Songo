//
//  MusicPlaylistModel.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import UIKit

class MusicPlaylistModel {
    
    var musicTitle: String
    var artist: String
    var musicPicture: UIImage
    
    init(musicTitle: String, artist: String, musicPicture: UIImage) {
        self.musicTitle = musicTitle
        self.artist = artist
        self.musicPicture = musicPicture
    }
    
}
