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
                Task{
                    lastSubscriptionUpdate
                }
            default:
                // TODO: Arrumar a lógica não posso dar fatal error
                appleMusicAuthorization = await MusicAuthorization.request()
            }
        }
       
    }
}
