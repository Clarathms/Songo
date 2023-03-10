//
//  SpotifyService.swift
//  Songo
//
//  Created by Amanda Melo on 14/02/23.
//

import Foundation

class SpotifyService: NSObject, MusicProtocol {
    var delegate: MusicProtocolDelegate?

    required override init() {
        super.init()
    }
    
    var id: StreamChoice = .spotify
    // MARK: - Fetch token and request access
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
//        AppData.shared.isConnected = false
        return appRemote
    }()
    
    var responseCode: String? {
        didSet {
            fetchAccessToken { (dictionary, error) in
                if let error = error {
                    print("Fetching token request error \(error)")
                    return
                }
                let accessToken = dictionary!["access_token"] as! String
                DispatchQueue.main.async {
                    self.appRemote.connectionParameters.accessToken = accessToken
                    self.appRemote.connect()
                }
            }
        }
    }
    
    var accessToken = UserDefaults.standard.string(forKey: accessTokenKey) {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(accessToken, forKey: accessTokenKey)
        }
    }
    
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: spotifyClientId, redirectURL: redirectUri)
        // Set the playURI to a non-nil value so that Spotify plays music after authenticating
        // otherwise another app switch will be required
        configuration.playURI = ""

        // Set these url's to your backend which contains the secret to exchange for an access token
        // You can use the provided ruby script spotify_token_swap.rb for testing purposes
        configuration.tokenSwapURL = URL(string: "http://localhost:1234/swap")
        configuration.tokenRefreshURL = URL(string: "http://localhost:1234/refresh")
        return configuration
    }()
    
    func fetchAccessToken(completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let spotifyAuthKey = "Basic \((spotifyClientId + ":" + spotifyClientSecretKey).data(using: .utf8)!.base64EncodedString())"
        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey,
                                       "Content-Type": "application/x-www-form-urlencoded"]

        var requestBodyComponents = URLComponents()
        let scopeAsString = stringScopes.joined(separator: " ")

        requestBodyComponents.queryItems = [
            URLQueryItem(name: "client_id", value: spotifyClientId),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: responseCode!),
            URLQueryItem(name: "redirect_uri", value: redirectUri.absoluteString),
            URLQueryItem(name: "code_verifier", value: ""), // not currently used
            URLQueryItem(name: "scope", value: scopeAsString),
        ]

        request.httpBody = requestBodyComponents.query?.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                              // is there data
                  let response = response as? HTTPURLResponse,  // is there HTTP response
                  (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                  error == nil else {                           // was there no error, otherwise ...
                      print("Error fetching token \(error?.localizedDescription ?? "")")
                      return completion(nil, error)
                  }
            let responseObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            print("Access Token Dictionary=", responseObject ?? "")
            completion(responseObject, nil)
        }
        task.resume()
    }
    
    lazy var sessionManager: SPTSessionManager? = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()
    
    func authenticate() {
        guard let sessionManager = sessionManager else {
            print("No Session Manager")
            return
        }
        sessionManager.initiateSession(with: scopes, options: .clientOnly)
    }
    
    
    //MARK: - Get information on user's current behaviour
    var currentTrack: SPTAppRemoteTrack?
    var currentTitle: String { currentTrack?.name ?? "No title found" }
//    var currentTitle: String { delegate?.didGet(song: SPTAppRemoteTrack)}
    var currentArtist: String { currentTrack?.artist.name ?? "No artist found" }
    var currentAlbum: String { currentTrack?.album.name ?? "No album found" }
    var currentImageIdentifier: String { currentTrack?.imageIdentifier ?? "No image found" }
    var currentPhotoData: Data?
    
    func fetchArtwork(for track: SPTAppRemoteTrack) {
        let mapView = self.delegate as? MapView
        DispatchQueue.main.async {
            self.appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize.zero, callback: { [weak self] (image, error) in
                if let error = error {
                    print("Error fetching track image: " + error.localizedDescription)
                } else if let image = image as? UIImage {
                    self?.currentPhotoData = image.jpegData(compressionQuality: 0.8)
                    mapView?.currentSongView?.albumImage.image = image
                }
            })
        }
        }

    
    func getCurrentPicture() async -> Bool {
//        print("entrou?")
//         await withCheckedContinuation { continuation in
//            getCurrentPicture { photoData in
//                continuation.resume(returning: photoData)
////                print("Print data atual")
////                print(self.currentPhotoData)
//            }
//
//        }
//        currentPhotoData
        
        if let currentTrack = currentTrack {
            fetchArtwork(for: currentTrack)
            return true
        }
        return false
    }
    
    
   func update(playerState: SPTAppRemotePlayerState) {
       currentTrack = playerState.track
       
       if delegate != nil {
           self.delegate!.didGet(song: self.currentTrack!)
               let mapView = self.delegate as! MapView
               mapView.currentSongView?.currentTitle.text = MapView.musicTitle
               mapView.currentSongView?.currentAlbum.text = MapView.musicAlbum
               mapView.currentSongView?.currentArtist.text = MapView.musicArtist
           }
    }
    
    func fetchPlayerState() {
        appRemote.playerAPI?.getPlayerState({ [weak self] (playerState, error) in
            if let error = error {
            } else if let playerState = playerState as? SPTAppRemotePlayerState {
                self?.update(playerState: playerState)
            }
        })
    }

}

