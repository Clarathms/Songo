//
//  MusicPlaylistModel.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import MapKit

class MusicPlaylistModel: MKClusterAnnotation {
    
    var musicTitles: String
    var artists: String
    var musicPlacements: [MusicPlacementModel]
    var musicPictures: [UIImage] = []

    
    init(musicTitles: String, artists: String, musicPictures: UIImage, musicPlacements: [MusicPlacementModel]) {
        self.musicPlacements = musicPlacements
        self.musicTitles = musicTitles
        self.artists = artists
        self.musicPictures = {
            var images: [UIImage] = []
            for music in musicPlacements {
                images.append(music.musicPicture ?? UIImage())
            }
            return images
        }()

        super.init(memberAnnotations: musicPlacements)
    }
    
}
