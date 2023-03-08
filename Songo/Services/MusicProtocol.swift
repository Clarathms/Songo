//
//  MusicProtocol.swift
//  Songo
//
//  Created by Amanda Melo on 15/02/23.
//

import Foundation
import MusicKit

typealias MusicList = [MusicProtocol]

protocol MusicProtocolDelegate: AnyObject {
    func didGet(song: Song)
    func didGet(song: SPTAppRemoteTrack)
}

protocol MusicProtocol {
    var currentTitle: String { get }
    var currentArtist: String { get }
    var currentAlbum: String { get }
    var currentPhotoData: Data? { get }
    var id: StreamChoice { get set }
    var delegate: MusicProtocolDelegate? { get set }
    init()
    
    func authenticate()
    func getCurrentPicture() async -> Bool
    
//    static func getCurrentMusic() async throws  -> MusicProtocol
//    static func search(music: String) async  -> MusicList
//    static func export(playlist: MusicList) async
//
//    func play()

}


enum MusicRequestError: Error {
    case musicRequestIsEmpty
}
