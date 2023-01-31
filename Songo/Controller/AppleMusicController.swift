//
//  MusicController.swift
//  Songo
//
//  Created by Amanda Melo on 27/01/23.
//

import Foundation
import MusicKit

class AppleMusicController {
    
    var appleMusicAuthorization: MusicAuthorization.Status = .notDetermined
    
    var currentMusicPlaying = SystemMusicPlayer.shared.queue.currentEntry
    
    var currentMusicRequest: MusicCatalogSearchRequest {
        return MusicCatalogSearchRequest(term: currentMusicPlaying?.title ?? "não", types: [Song.self])
    }
    
    func getSearchResponse() {
        Task {
            do {
                let searchResponse = try await currentMusicRequest.response()
                dump(searchResponse)
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
