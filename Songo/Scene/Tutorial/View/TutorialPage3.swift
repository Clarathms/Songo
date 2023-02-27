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
    @State private var canShowAppleM = false
    @State var isPresented: Bool = false
    @Binding var chamaBotao : Bool
    @State private var isShowingOffer = true
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default
//    let appleMusicService: AppleMusicService = AppleMusicService()
//    let spotifyService: SpotifyService = SpotifyService()
    var appleImg = Image(systemName: "applelogo")
    
    var botaoAppleMusic: some View {
        Button {
            isPresented = true
            AppData.shared.currentStreaming = StreamChoice.appleMusic
        } label: {
            Text("\(appleImg)  Login com Apple Music")
                .bold()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/16)
                        .shadow(color: .gray, radius: 3, x: 0, y: 2)

                )
        }
    }
    var botaoSpotify: some View {
        Button {
            isPresented = true
            AppData.shared.currentStreaming = StreamChoice.spotify
        } label: {
            Text("Login com Spotify")
                .bold()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.green)
                        .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/16)
                        .shadow(color: .gray, radius: 3, x: 0, y: 2)

                )
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX/2,y:UIScreen.main.bounds.midY/1.1)
            
            VStack(spacing: 60){
                VStack(spacing: 20){
                    Text("Atenção!")
                        .font(.title)
                    Text("Para utilizar o aplicativo, \n é necessário ter conta no Apple Music \n ou Spotify")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }

                
                botaoSpotify
                if chamaBotao {
                    botaoAppleMusic
                }
//                if (chamaBotao : $chamaBotao.wrappedValue) {
//
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
                
            }.position(x:UIScreen.main.bounds.midX/1.2,y:UIScreen.main.bounds.midY*1.2)
//                .task {
//                    <#code#>
//                }
//                .task {
//                    let subCheck = await appleMusicService.lastSubscriptionUpdate().makeSubscriptionOffer
//                    DispatchQueue.main.async {
//                        print("aaaa\(subCheck)")
//                        subscriptionOfferOptions.messageIdentifier = .playMusic
//                        isShowingOffer = subCheck
//                        if isShowingOffer != subCheck{
//                            isShowingOffer = false
//                        }
//                        if !isShowingOffer{
//                            chamaBotao = true
//                        }
//                    }
//                }
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

//struct TutorialPage3_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialPage3()
//    }
//}

