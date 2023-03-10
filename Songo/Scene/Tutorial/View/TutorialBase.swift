//
//  AuthorizationView.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 25/01/23.
//

import Foundation
import SwiftUI
import MusicKit

struct TutorialBase: View {
    
    @State var isAuthorized = false
    @State var texto: String = "oi"
    // tutorial
    @State private var selectedTab = 1
    @State private var lastTab = 0
    
    @State var chamaBotao : Bool = false
    @State private var isShowingOffer = true
    @State private var subscriptionOfferOptions: MusicSubscriptionOffer.Options = .default
  //  let appleMusicController: AppleMusicController = AppleMusicController()
    
//    @State var chamaBotao : Bool = false
    //@State var isShowingOffer: Bool = true
    let appleMusicService: AppleMusicService = AppleMusicService()


    var body: some View {
        
        //let yExtension: CGFloat = 50
        NavigationView{
                VStack(alignment: .leading, spacing: 0){
                    TabView(selection: $selectedTab){
                        
                        TutorialPage1(chamaBotao: $chamaBotao)
                            .tabItem({
                                Image(systemName: "circle")
                            })
                            .tag(1)
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
                            .musicSubscriptionOffer(isPresented: $isShowingOffer, options: subscriptionOfferOptions)
                                .onAppear{
                                    appleMusicService.checkAppleMusicAuthorization()
                                    isShowingOffer = true
                                    
                                }
                        
                        TutorialPage2(chamaBotao: $chamaBotao).tabItem({
                            Image(systemName: "circle")
                        }).tag(2)
                        
                        TutorialPage3(chamaBotao: $chamaBotao).tabItem({
                            Image(systemName: "circle")
                        }).tag(3)
                       
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .background(
                        Image("FotoFundo")
                        .resizable()
                        .scaledToFill())
                    .ignoresSafeArea(.all)
                }
            
                
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(UIColor.fundoSecundario))
        .onChange(of: selectedTab) { [selectedTab] value in
//            if selectedTab < value{
//                generator.selectionChanged()
//            }
        }
        
        
       
        
    }
}

extension TutorialBase {
    func requestAuthorization() {
        // detach
        Task{
            let authorizationStatus = await MusicAuthorization.request()
            switch authorizationStatus {
            case .authorized:
                DispatchQueue.main.async {
                    texto = "autorizado"
                }
                
                break
            default:
                DispatchQueue.main.async {
                    texto = "não autorizado"
                }
                break
                
            }
        
    }
}

}

//
//struct AuthorizationView_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialBase()
//    }
//}
