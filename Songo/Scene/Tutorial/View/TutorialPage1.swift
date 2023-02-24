//
//  TutorialPage1.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 26/01/23.
//

import Foundation
import SwiftUI
import MusicKit

struct TutorialPage1: View {
    
    @State private var isShowingOffer = true
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default
    let appleMusicService: AppleMusicService = AppleMusicService()
    @State var isPresented: Bool = false
    @State var teste: Bool = true
    @Binding var chamaBotao: Bool
    var botao: some View {
        Button {
            isPresented = true
        } label: {
            Text("Pular")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX*2,y:UIScreen.main.bounds.midY/1.1)
            
            RoundedRectangle(cornerSize: .init(width: 130, height: 130))
                .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX*1.2,y:UIScreen.main.bounds.midY/1.1)
                .overlay{
                    VStack (spacing: 40) {
                        VStack(spacing: 20){
                            Text("Seja bem-vindo ao SoundMap!")
                                .font(.headline)
                            Text("No SoundMap você conseguirá \n montar sua identidade sonoro-musical  \n através da sua localização.")
                                .lineLimit(3)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                        }
                        if chamaBotao {
                            botao
                        }
                    }.position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY*1.2)
//                    .task {
//                        let subCheck = await appleMusicService.lastSubscriptionUpdate().makeSubscriptionOffer
//                        DispatchQueue.main.async {
//                            subscriptionOfferOptions.messageIdentifier = .playMusic
//                            isShowingOffer = subCheck
//                            if isShowingOffer != subCheck{
//                                isShowingOffer = false
//                            }
//                            if !isShowingOffer{
//                                chamaBotao = true
//                            }
//                        }
//                    }
                }
        }.musicSubscriptionOffer(isPresented: $isShowingOffer, options: subscriptionOfferOptions)
            .onAppear{
                appleMusicService.checkAppleMusicAuthorization()
                isShowingOffer = true
                
            }
            .fullScreenCover(isPresented: $isPresented) {
                GoToVC().edgesIgnoringSafeArea(.all)
            }
    }
}
//struct TutorialPage1_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialPage1()
//    }
//}
//                            if isShowingOffer{
//                                chamaBotao = false
//                            }
//                            else{
//                                chamaBotao = true
//                            }
