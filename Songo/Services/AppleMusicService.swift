//
//  AppleMusicService.swift
//  Songo
//
//  Created by Amanda Melo on 27/01/23.
//

import Foundation
import MusicKit

class AppleMusicService: MusicProtocol {
    var currentPhotoData: Data
    
    required init() {
        <#code#>
    }
    
    static func getCurrentMusic() async -> MusicProtocol {
        <#code#>
    }
    
    
    private var currentMusic: Song?
    var currentTitle: String { currentMusic?.title ?? "No title found" }
    var currentArtist: String { currentMusic?.artistName ?? "No artist found" }
    var currentURLPicture: URL? { currentMusic?.artwork?.url(width: currentMusic?.artwork!.maximumWidth ?? 0, height: currentMusic?.artwork!.maximumHeight ?? 0) }
    var currentAlbum: String { currentMusic?.albumTitle ?? "No album found" }
    var currentPicture: UIImage?
    var appleMusicAuthorization: MusicAuthorization.Status = .notDetermined

    init(currentMusic: Song) {
        self.currentMusic = currentMusic
        
    }
    
    
    static func getCurrentMusic() async throws -> MusicProtocol {
        let currentMusicPlaying = SystemMusicPlayer.shared.queue.currentEntry?.item?.id
            do {
                var currentMusicRequest: MusicCatalogResourceRequest<Song> { MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: currentMusicPlaying!) }
                let searchResponse = try await currentMusicRequest.response()
                guard let song = searchResponse.items.first else {
                    // tratar que deu riom
                    throw MusicRequestError.musicRequestIsEmpty
                }
                return AppleMusicService(currentMusic: song)
            } catch {
                throw error
            }
    }
    
//MARK: - Checagem de assinatura do Apple Music e pedido de autorização para trackeamento de informação
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
