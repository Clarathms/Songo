//
//  MusicController.swift
//  Songo
//
//  Created by Amanda Melo on 27/01/23.
//

import Foundation
import MusicKit

class AppleMusicController {
    
    private var currentMusic: Song?
    var currentTitle: String { currentMusic?.title ?? "No title found" }
    var currentArtist: String { currentMusic?.artistName ?? "No artist found" }
    var currentPicture: Artwork? { currentMusic?.artwork }
    var currentAlbum: String { currentMusic?.albumTitle ?? "No album found" }
    var appleMusicAuthorization: MusicAuthorization.Status = .notDetermined
    
    private func getCurrentMusic()  {
        Task {
            var currentMusicPlaying = SystemMusicPlayer.shared.queue.currentEntry?.item?.id
            do {
                var currentMusicRequest: MusicCatalogResourceRequest<Song> {MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: currentMusicPlaying!)}
                let searchResponse = try await currentMusicRequest.response()
                currentMusic = searchResponse.items.first
            } catch {
                print("Search request failed with error: \(error).")
            }
        }
    }

    func lastSubscriptionUpdate() async -> (makeSubscriptionOffer:Bool, canPlayMusic:Bool) {
        var appleMusicSubscription: MusicSubscription?
            for await status in MusicSubscription.subscriptionUpdates {
                appleMusicSubscription = status
        }
        return (appleMusicSubscription?.canBecomeSubscriber ?? false, appleMusicSubscription?.canPlayCatalogContent ?? false)
    }
    
    func checkAppleMusicAuthorization()  {
        Task{
            switch appleMusicAuthorization {
            case .notDetermined:
                appleMusicAuthorization = await MusicAuthorization.request()
            case .authorized:
                Task {lastSubscriptionUpdate}

            default:
                // TODO: Arrumar a lógica não posso dar fatal error
                appleMusicAuthorization = await MusicAuthorization.request()
            }
        }
    }
}
