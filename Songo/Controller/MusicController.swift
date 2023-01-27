//
//  MusicController.swift
//  Songo
//
//  Created by Amanda Melo on 27/01/23.
//

import Foundation
import MusicKit

class MusicController {
    
    var appleMusicAuthorization: MusicAuthorization.Status

    var userCurrentSong: String? = ApplicationMusicPlayer.shared.queue.currentEntry?.id
    
    init(appleMusicAuthorization: MusicAuthorization.Status, userCurrentSong: String? = nil) {
        self.appleMusicAuthorization = appleMusicAuthorization
        self.userCurrentSong = userCurrentSong
    }
    
    
    
    func checkAppleMusicAuthorization() async {
        switch appleMusicAuthorization {
        case .notDetermined:
            appleMusicAuthorization = await MusicAuthorization.request()
        default:
            fatalError("No button should be displayed for current authorization status: \(appleMusicAuthorization).")
        }
    }

}
