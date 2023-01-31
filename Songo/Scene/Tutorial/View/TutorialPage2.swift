//
//  TutorialPage2.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 26/01/23.
//
import Foundation
import SwiftUI

struct TutorialPage2: View {
    var body: some View {
        ZStack{
                    VStack(spacing: 20){
                        Text("Lembre do momento atráves de playlists")
                            .font(.headline)
                        Text("No SoundMap você conseguira montar \n sua identidade sonoro-musical através da \n sua localização.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                        
                        NavigationLink(destination: GoToVC()) {
                            Text("Pular")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }.padding(.top)
                        
                    }.position(x:UIScreen.main.bounds.midX/1.02,y:UIScreen.main.bounds.midY*1.2)
                    
                
        }.background( Rectangle()
                      //                .frame(width: UIScreen.main.bounds.width*1.5,height: UIScreen.main.bounds.height/1.1)
                          .frame(width: UIScreen.main.bounds.width*1.2,height: UIScreen.main.bounds.height/1.15)
                          .foregroundColor(Color.white)
                          .position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY/1.097))
    }
}
struct TutorialPage2_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage2()
    }
}
