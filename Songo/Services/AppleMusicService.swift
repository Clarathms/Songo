//
//  AppleMusicService.swift
//  Songo
//
//  Created by Amanda Melo on 27/01/23.
//

import Foundation
import MusicKit

struct AppleMusicService {
    var appleMusicAuthorization: MusicAuthorization.Status
    var appleMusicSubscription: MusicSubscription?

    private var makeSubscriptionOffer: Bool {
        return appleMusicSubscription?.canBecomeSubscriber ?? false
    }
    private var canPlayMusic: Bool {
        return appleMusicSubscription?.canPlayCatalogContent ?? false
    }
    
    mutating func checkAppleMusicSubscription () async {
        for await status in MusicSubscription.subscriptionUpdates {
            appleMusicSubscription = status
        }
    }
    mutating func checkAppleMusicAuthorization() async {
        switch appleMusicAuthorization {
        case .notDetermined:
            appleMusicAuthorization = await MusicAuthorization.request()
        case .authorized:
            DispatchQueue.main.async {
                var texto = "autorizado"
            }
        default:
            fatalError("No button should be displayed for current authorization status: \(appleMusicAuthorization).")
//            DispatchQueue.main.async {
//                var texto = "não autorizado"
//            }
        }
    }
}
