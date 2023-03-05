//
//  TutorialPage2.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 26/01/23.
//
import Foundation
import SwiftUI
import MusicKit

struct TutorialPage2: View {
    @State var isPresented: Bool = false
    @State private var isShowingOffer = true
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default
    let appleMusicService: AppleMusicService = AppleMusicService()
//    @State var isPresented: Bool = false
    @Binding var chamaBotao : Bool

    var botao: some View {
        Button {
            isPresented = true
        } label: {
            Text("Pular")
                .font(.headline)
                .foregroundColor(.black)
                .underline()
        }
    }
    var body: some View {
        ZStack{
            Rectangle()
           
                .frame(width: UIScreen.main.bounds.width*1.2,height: UIScreen.main.bounds.height/1.08)
                  .foregroundColor(Color(UIColor.fundoSecundario))
                  .position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY/1.097)
            Rectangle()
           
                  .frame(width: UIScreen.main.bounds.width*1.2,height: UIScreen.main.bounds.height/1.15)
                  .foregroundColor(Color.white)
                  .position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY/1.097)
                  .overlay{
                      VStack(spacing:50){
                      VStack(spacing:-30)  {
                          Image("ilustr02")
                              .resizable()
                              .scaledToFit()
                              .frame(width: UIScreen.main.bounds.width/2
                                     , height: UIScreen.main.bounds.height/2)
                          VStack(spacing: 20){
                              Text("Relembre os momentos atráves de playlists")
                                  .font(.headline)
                              Text("Adicione a música que está ouvindo \n em sua localização atual e crie playlists \n  alterando o zoom no mapa.")
                                  .font(.subheadline)
                                  .multilineTextAlignment(.center)
                              
                              
                          }
                      }
                          if chamaBotao {
                              botao
                          }
                      }.position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY/1.3)
                  }
        }
        .musicSubscriptionOffer(isPresented: $isShowingOffer, options: subscriptionOfferOptions)
            .onAppear{
                appleMusicService.checkAppleMusicAuthorization()
                isShowingOffer = true
                
            }
        .fullScreenCover(isPresented: $isPresented) {
            GoToVC().edgesIgnoringSafeArea(.all)
        }
    }
}
