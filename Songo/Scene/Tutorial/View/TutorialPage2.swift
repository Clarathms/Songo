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
            RoundedRectangle(cornerSize: .init(width: 120, height: 120))
                .frame(width: UIScreen.main.bounds.width*1.5,height: UIScreen.main.bounds.height/1.1)
                .foregroundColor(Color.white)
                .position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY/1.08)
                .overlay{
                    VStack(spacing: 20){
                        Text("Seja bem-vindo ao SoundMap!")
                            .font(.headline)
                        Text("No SoundMap você conseguira montar \n sua identidade sonoro-musical \n através da sua localização.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                        
                    }.position(x:UIScreen.main.bounds.midX,y:UIScreen.main.bounds.midY*1.2)
                    
                }
        }
    }
}
struct TutorialPage2_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage2()
    }
}
