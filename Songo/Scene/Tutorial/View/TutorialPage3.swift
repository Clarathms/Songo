//
//  TutorialPage3.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 26/01/23.
//

import Foundation
import SwiftUI
import MusicKit

struct TutorialPage3: View {
    
  //  @State teste: Bool = true
    @State var isPresented: Bool = false
    @State var chamaBotao : Bool = false
    @State private var isShowingOffer = true
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default
    let appleMusicService: AppleMusicService = AppleMusicService()
//    let spotifyService: SpotifyService = SpotifyService()
    var botaoAppleMusic: some View {
        Button {
            isPresented = true
            AppData.shared.currentStreaming = StreamChoice.appleMusic
        } label: {
            Text("Login com Apple Music")
                .bold()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(UIColor.fundoSecundario))
                        .frame(width: UIScreen.main.bounds.width/4.2, height: UIScreen.main.bounds.height/16)
                )
        }
    }
    var botaoSpotify: some View {
        Button {
            isPresented = true
//            guard let sessionManager = spotifyService.sessionManager else { return }
//            sessionManager.initiateSession(with: scopes, options: .clientOnly)
            AppData.shared.currentStreaming = StreamChoice.spotify
        } label: {
            Text("Login com Spotify")
                .bold()
                .foregroundColor(.black)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.green)
                        .frame(width: UIScreen.main.bounds.width/4.2, height: UIScreen.main.bounds.height/16)
                )
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX/2,y:UIScreen.main.bounds.midY/1.1)
            
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Text("Atenção!")
                        .font(.title)
                    Text("Para utilizar o aplicativo, \n é necessário ter conta no Apple Music")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                botaoAppleMusic
                botaoSpotify
                
//                if chamaBotao {
//                    botaoAppleMusic
//                }
                
//                Button {
//                    isPresented = true
//                } label: {
//                    Text("Vamos lá")
//                        .bold()
//                        .foregroundColor(.white)
//                        .background(
//                            RoundedRectangle(cornerRadius: 30)
//                                .foregroundColor(Color(UIColor.fundoSecundario))
//                                .frame(width: UIScreen.main.bounds.width/4.2, height: UIScreen.main.bounds.height/16)
//                        )
//                }
//                .padding(.top,50)
                
            }.position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY*1.2)
            //.position(x:UIScreen.main.bounds.midX*0.85,y:UIScreen.main.bounds.midY*1.2)
                .task {
                    let subCheck = await appleMusicService.lastSubscriptionUpdate().makeSubscriptionOffer
                    DispatchQueue.main.async {
                        subscriptionOfferOptions.messageIdentifier = .playMusic
                        isShowingOffer = subCheck
                        if isShowingOffer != subCheck{
                            isShowingOffer = false
                        }
                        if !isShowingOffer{
                            chamaBotao = true
                        }
                    }
                }
                .background(
                    
                    RoundedRectangle(cornerSize: .init(width: 130, height: 130))
                        .frame(width: UIScreen.main.bounds.width/1.2,height: UIScreen.main.bounds.height/1.15)
                        .foregroundColor(Color.white)
                        .position(x:UIScreen.main.bounds.midX/1.05,y:UIScreen.main.bounds.midY/1.1)
                )
                .fullScreenCover(isPresented: $isPresented) {
                    GoToVC().edgesIgnoringSafeArea(.all)
                }
        }
        
    }
}

struct TutorialPage3_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage3()
    }
}

extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 8) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))
        
        return self
            .overlay(
                shape
                    .stroke(color, lineWidth: width)
                    .offset(x: finalX * width * 0.3, y: finalY * width * 0.3)
                    .blur(radius: blur)
                    .mask(shape)
            )
    }
    
}
