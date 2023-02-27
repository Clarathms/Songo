//
//  AppleMusicService.swift
//  Songo
//
//  Created by Amanda Melo on 27/01/23.
//

import Foundation
import MusicKit
import Combine

class AppleMusicService: MusicProtocol {

    weak var delegate: MusicProtocolDelegate?
    
    
    
    required init() {}
    
    // MARK: - Get current music and its data from the user account
    private var currentMusic: Song?
    var currentMusicID: MusicItemID?
    var currentTitle: String { currentMusic?.title ?? "No title found" }
    var currentArtist: String { currentMusic?.artistName ?? "No artist found" }
    var currentURLPicture: URL? { currentMusic?.artwork?.url(width: currentMusic?.artwork!.maximumWidth ?? 0, height: currentMusic?.artwork!.maximumHeight ?? 0) }
    var currentAlbum: String { currentMusic?.albumTitle ?? "No album found" }
    var currentPhotoData: Data?
    var id: StreamChoice = .appleMusic

    var cancellable: Cancellable?
    
    func authenticate() {
        checkAppleMusicAuthorization()
        cancellable = SystemMusicPlayer.shared.state.objectWillChange.sink(receiveValue: { state in
            let musicState = SystemMusicPlayer.shared.state.playbackStatus
            self.currentMusicID = SystemMusicPlayer.shared.queue.currentEntry?.item?.id
            Task {
                    await self.getCurrentMusic()
                    print(self.currentTitle, "<------")
            }
            print(self.currentMusicID)
        })
    }
    func update(playerState: Song) {
        
        print("entrou aqui")
        currentMusic = playerState.self
        delegate?.didGet(song: currentMusic!)
        
        if delegate != nil {
            DispatchQueue.main.async {
                let mapView = self.delegate as! MapView
                mapView.currentSongView?.currentTitle.text = MapView.musicTitle
                mapView.currentSongView?.currentAlbum.text = MapView.musicAlbum
                mapView.currentSongView?.currentArtist.text = MapView.musicArtist
                
                //           mapView.currentSongView?.currentData? = self.currentPhotoData!
                // mapView.currentSongView?.currentPhotoStringAdd? = MapView.musicPhotoString!
                print("****** Novo print *******")
                //           print(mapView.currentSongView?.currentData)
                //  print(mapView.currentSongView?.currentPhotoStringAdd)
                print("Novo print *******")
                print(mapView.currentSongView?.currentTitle.text)
            }
            //       currentTitle = currentTrack.name
        }
        else {
            
         print("delegate nulo")
        }
     }
    
    func getCurrentMusic() async {
        let currentMusicPlaying = self.currentMusicID
            do {
                var currentMusicRequest: MusicCatalogResourceRequest<Song> { MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: currentMusicPlaying!) }
                let searchResponse = try await currentMusicRequest.response()
                currentMusic = searchResponse.items.first
            //    delegate?.didGet(song: currentMusic!)
                update(playerState: currentMusic!)
//                if delegate != nil {
//                    Task{ @MainActor in
//                        let mapView = delegate as! MapView
//
//                        mapView.currentSongView?.currentTitle.text = MapView.musicTitle
//                        mapView.currentSongView?.currentAlbum.text = MapView.musicAlbum
//                        mapView.currentSongView?.currentArtist.text = MapView.musicArtist
//
//                        print("Novo print *******")
//                        print(mapView.currentSongView?.currentTitle.text!)
//                        //       currentTitle = currentTrack.name
//                    }
//                }
//                else {
//
//                 print("delegate nulo")
//                }
            } catch {
                print("Search request failed with error: \(error).")
            }
    }
    
    func getCurrentPicture() async -> Bool{
        guard let url = self.currentURLPicture else { return false }
        
        if let data = try? Data(contentsOf: url) {
            currentPhotoData = data
        }
        return true
    }
    
//MARK: - Checagem de assinatura do Apple Music e pedido de autorização para trackeamento de informação
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
                Task {lastSubscriptionUpdate}
            default:
                // TODO: Arrumar a lógica não posso dar fatal error
                appleMusicAuthorization = await MusicAuthorization.request()
            }
        }
    }
}
