////
////  MusicController.swift
////  Songo
////
////  Created by Amanda Melo on 27/01/23.
////
//
//import Foundation
//import MusicKit
//import SwiftUI
//
//class AppleMusicService {
//
//    private var currentMusic: Song?
//    var currentTitle: String { currentMusic?.title ?? "No title found" }
//    var currentArtist: String { currentMusic?.artistName ?? "No artist found" }
//    var currentURLPicture: URL? { currentMusic?.artwork?.url(width: currentMusic?.artwork!.maximumWidth ?? 0, height: currentMusic?.artwork!.maximumHeight ?? 0) }
//    var currentAlbum: String { currentMusic?.albumTitle ?? "No album found" }
//    var currentPicture: UIImage?
//    var appleMusicAuthorization: MusicAuthorization.Status = .notDetermined
//
//
//    func getCurrentMusic() async {
//        let currentMusicPlaying = SystemMusicPlayer.shared.queue.currentEntry?.item?.id
//            do {
//                var currentMusicRequest: MusicCatalogResourceRequest<Song> { MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: currentMusicPlaying!) }
//                let searchResponse = try await currentMusicRequest.response()
//                currentMusic = searchResponse.items.first
//            } catch {
//                print("Search request failed with error: \(error).")
//            }
//    }
///// Checagem de assinatura do Apple Music e pedido de autorização para trackeamento de informação
//    func lastSubscriptionUpdate() async -> (makeSubscriptionOffer:Bool, canPlayMusic:Bool) {
//        var appleMusicSubscription: MusicSubscription?
//            for await status in MusicSubscription.subscriptionUpdates {
//                appleMusicSubscription = status
//        }
//        return (appleMusicSubscription?.canBecomeSubscriber ?? false, appleMusicSubscription?.canPlayCatalogContent ?? false)
//    }
//
//    func checkAppleMusicAuthorization()  {
//        Task{
//            switch appleMusicAuthorization {
//            case .notDetermined:
//                appleMusicAuthorization = await MusicAuthorization.request()
//            case .authorized:
//                Task {lastSubscriptionUpdate}
//            default:
//                // TODO: Arrumar a lógica não posso dar fatal error
//                appleMusicAuthorization = await MusicAuthorization.request()
//            }
//        }
//    }
//}
