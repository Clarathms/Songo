//
//  AuthorizationView.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 25/01/23.
//

import Foundation
import SwiftUI
import MusicKit

struct AuthorizationView: View {
    
    @State var isAuthorized = false
    @State var texto: String = "oi"
    // tutorial
    @State private var selectedTab = 1
    @State private var lastTab = 0
   // @Binding var showingTutorial:Bool

    var body: some View {
        
        
        
        //let yExtension: CGFloat = 50
        GeometryReader{ geometry in
                VStack(alignment: .leading, spacing: 0){
                    TabView(selection: $selectedTab){
                        
                        TutorialPage1()
                            .tabItem({
                                Image(systemName: "1.square")
                            })
                            .tag(1)
                        
                        TutorialPage2().tabItem({
                            Image(systemName: "2.square")
                        }).tag(2)
                        
                        TutorialPage3().tabItem({
                            Image(systemName: "3.square")
                        }).tag(3)
                       
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    
                   // Spacer().frame(height: 25)
                }
                
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.blue)
        .onChange(of: selectedTab) { [selectedTab] value in
//            if selectedTab < value{
//                generator.selectionChanged()
//            }
        }
        
        
        Text(texto)
            .onAppear{
                requestAuthorization()
            }
        
    }
}

extension AuthorizationView {
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


struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
