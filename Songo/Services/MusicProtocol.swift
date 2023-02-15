//
//  MusicProtocol.swift
//  Songo
//
//  Created by Amanda Melo on 15/02/23.
//

import Foundation

typealias MusicList = [MusicProtocol]

protocol MusicProtocol {
    var currentTitle: String { get }
    var currentArtist: String { get }
    var currentAlbum: String { get }
    var currentPhotoData: Data? { get }
    
    init()
    
//    static func getCurrentMusic() async throws  -> MusicProtocol
//    static func search(music: String) async  -> MusicList
//    static func export(playlist: MusicList) async
//
//    func play()

}


enum MusicRequestError: Error {
    case musicRequestIsEmpty
}
