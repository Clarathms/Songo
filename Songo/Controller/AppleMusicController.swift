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
    var appleMusicSubscription: MusicSubscription?

    private var makeSubscriptionOffer: Bool {
        return appleMusicSubscription?.canBecomeSubscriber ?? false
    }
    private var canPlayMusic: Bool {
        return appleMusicSubscription?.canPlayCatalogContent ?? false
    }
    
    func checkAppleMusicSubscription() {
        Task{
            for await status in MusicSubscription.subscriptionUpdates {
                appleMusicSubscription = status
            }
        }
    }
    
    func checkAppleMusicAuthorization()  {
        Task{
            switch appleMusicAuthorization {
            case .notDetermined:
                appleMusicAuthorization = await MusicAuthorization.request()
            default:
                // TODO: Arrumar a lógica não posso dar fatal error
                fatalError("No button should be displayed for current authorization status: \(appleMusicAuthorization).")
            }
        }
       
    }
}
