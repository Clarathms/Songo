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
    
    @State private var canShowAppleM = false
    @State var isPresented: Bool = false
    @Binding var chamaBotao : Bool
    @State private var isShowingOffer = true
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default

    var appleImg = Image(systemName: "applelogo")
    var spotifyLogo = Image(systemName: "logoSpotify").resizable()
    
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
                        .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/17)
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
                        .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/17)
                        .shadow(color: .gray, radius: 3, x: 0, y: 2)

                )
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/1.08)
                .foregroundColor(Color(UIColor.fundoSecundario))
                .position(x:UIScreen.main.bounds.midX/2,y:UIScreen.main.bounds.midY/1.1)
            RoundedRectangle(cornerSize: .init(width: 130, height: 130))
                .frame(width: UIScreen.main.bounds.width/1.05,height: UIScreen.main.bounds.height/1.08)
                .foregroundColor(Color(UIColor.fundoSecundario))
                .position(x:UIScreen.main.bounds.midX/1.05,y:UIScreen.main.bounds.midY/1.1)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX/2,y:UIScreen.main.bounds.midY/1.1)
            
            RoundedRectangle(cornerSize: .init(width: 130, height: 130))
                .frame(width: UIScreen.main.bounds.width/1.2,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX/1.05,y:UIScreen.main.bounds.midY/1.1)
                .overlay{
                    
                    VStack(spacing:70){
                        VStack(spacing:60){
                            
                            Image(systemName: "waveform.badge.exclamationmark")
                                .foregroundColor(Color(UIColor.fundoSecundario))
                                .font(.system(size: 150))
                                .scaledToFit()
                            
                            
                            VStack(spacing: 20){
                                Text("Atenção!")
                                    .font(.title)
                                Text("Para utilizar o aplicativo, \n é necessário ter conta no Apple Music \n ou Spotify")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                            }
                            
                        }
                        VStack(spacing: 60){
                            botaoSpotify
                            if chamaBotao {
                                botaoAppleMusic
                            }
                        }
                        
                    }.position(x:UIScreen.main.bounds.midX/1.2,y:UIScreen.main.bounds.midY)
                }
                    
                .fullScreenCover(isPresented: $isPresented) {
                    GoToVC().edgesIgnoringSafeArea(.all)
                }
        }
        
    }
    
    
}
