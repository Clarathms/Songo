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
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerSize: .init(width: 130, height: 130))
                .frame(width: UIScreen.main.bounds.width*1.2,height: UIScreen.main.bounds.height/1.08)
                .foregroundColor(Color(UIColor.fundoSecundario))
                .position(x:UIScreen.main.bounds.midX*1.3,y:UIScreen.main.bounds.midY/1.1)

            Rectangle()
                .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX*2,y:UIScreen.main.bounds.midY/1.1)
            
            RoundedRectangle(cornerSize: .init(width: 130, height: 130))
                .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/1.15)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX*1.2,y:UIScreen.main.bounds.midY/1.1)

            

                .overlay{
                    VStack(spacing:-30)  {
                        Image("ilustr01")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width/2
                            , height: UIScreen.main.bounds.height/2)
                        VStack(spacing: 20){
                            Text("TutPage1.1")
                                .font(.headline)
                            Text("TutPage1.2")
                                .lineLimit(3)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                        }
                   
                    }.position(x:UIScreen.main.bounds.midX*1.08,y:UIScreen.main.bounds.midY/1.3)

                        
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
