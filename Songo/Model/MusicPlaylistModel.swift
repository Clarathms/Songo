//
//  MusicPlaylistModel.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation

class MusicPlaylistModel: Codable {
    
    var musicTitle: String
    var artist: String
    var musicPicture: URL
    
    init(musicTitle: String, artist: String, musicPicture: URL) {
        self.musicTitle = musicTitle
        self.artist = artist
        self.musicPicture = musicPicture
    }
    
}
