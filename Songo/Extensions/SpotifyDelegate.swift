//
//  SPTAppRemoteDelegate.swift
//  Songo
//
//  Created by Amanda Melo on 14/02/23.
//

import Foundation
import UIKit

//var spotifyService: SpotifyService = SpotifyService()

// MARK: - SPTAppRemotePlayerAPIDelegate
extension SpotifyService: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print(#function )
        print("__________", playerState.description)
        debugPrint("Spotify Track name: %@", playerState.track.name)
        //        self.currentTrack = playerState.track
        fetchArtwork(for: playerState.track)
        update(playerState: playerState)
        
    }
    
}

extension SpotifyService: SPTAppRemoteDelegate {
    
    
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print(#function )
        AppData.shared.isConnected = true
        appRemote.playerAPI?.delegate = self
        appRemote.playerAPI?.subscribe(toPlayerState: { (success, error) in
            if let error = error {
                print("Error subscribing to player state:" + error.localizedDescription)
            }
        })
//        appRemote.playerAPI?.getPlayerState({ [weak self] (playerState, error) in
//            if let error = error {
//                print("Error getting player state:" + error.localizedDescription)
//            } else if let playState = playerState as? SPTAppRemotePlayerState {
//                self?.currentTrack = playState.track
//            }
//        })
        fetchPlayerState()
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print(#function )
//        updateViewBasedOnConnected()
//        lastPlayerState = nil
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print(#function, error )
//        updateViewBasedOnConnected()
//        lastPlayerState = nil
        print("###### EROOR")
    }
}

// MARK: - SPTSessionManagerDelegate
extension SpotifyService: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(#function )
        if error.localizedDescription == "The operation couldn’t be completed. (com.spotify.sdk.login error 1.)" {
            print("AUTHENTICATE with WEBAPI")
            AppData.shared.isConnected = false
        } else {
            AppData.shared.isConnected = false
//            presentAlertController(title: "Authorization Failed", message: error.localizedDescription, buttonTitle: "Bummer")
        }
                
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print(#function )
//        presentAlertController(title: "Session Renewed", message: session.description, buttonTitle: "Sweet")
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print(#function )
        AppData.shared.isConnected = true
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
    }
}




