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
    
    @State var texto: String = "oi"
    @State private var isShowingOffer = true
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default
    let appleMusicController: AppleMusicController = AppleMusicController()
   
    
    var body: some View {
        ZStack{        
            Text(texto)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX*2,y:UIScreen.main.bounds.midY/1.1)

            RoundedRectangle(cornerSize: .init(width: 130, height: 130))
                .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX*1.2,y:UIScreen.main.bounds.midY/1.1)
                .overlay{
                    VStack(spacing: 20){
                        Text("Seja bem-vindo ao SoundMap!")
                            .font(.headline)
                        Text("No SoundMap você conseguirá \n montar sua identidade sonoro-musical  \n através da sua localização.")
                                .lineLimit(3)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                            
                            NavigationLink(destination: GoToVC()) {
                                Text("Pular")
                                    .font(.subheadline)
                                .foregroundColor(.gray)
                        }.padding(.top)
                        
                    }.position(x:UIScreen.main.bounds.midX*1.08,y:UIScreen.main.bounds.midY*1.2)
                

                }
        }.musicSubscriptionOffer(isPresented: $isShowingOffer, options: subscriptionOfferOptions)
            .onAppear{
                Task {
                    await appleMusicController.getCurrentMusic()
                    dump(appleMusicController.currentTitle)
                    dump(appleMusicController.currentAlbum)
                    dump(appleMusicController.currentArtist)
                }
                appleMusicController.checkAppleMusicAuthorization()
            
        }
            
        }
    
    
    
    private var subscriptionOfferButton: some View {
        Button(action: offerButtonSelected) {
            HStack {
                Image(systemName: "applelogo")
                Text("Join")
            }
            .frame(maxWidth: 200)
        }
    }
    
    private func offerButtonSelected() {
        isShowingOffer.toggle()
     }
}
struct TutorialPage1_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage1()
    }
}
