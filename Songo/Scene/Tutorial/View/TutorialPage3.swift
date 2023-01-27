//
//  TutorialPage3.swift
//  Songo
//
//  Created by Clara Thaís Maciel e Silva on 26/01/23.
//
import Foundation
import SwiftUI

struct TutorialPage3: View {
    var body: some View {
        NavigationView{
            ZStack{
                Text("foi?")
                NavigationLink(destination: GoToVC()) {
                    RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                    
                     .frame(width: UIScreen.main.bounds.width/2.5,height: UIScreen.main.bounds.width/5)
                        .foregroundColor(Color("corBotao"))
                        .innerShadow(using: RoundedRectangle(cornerSize: .init(width: 20, height: 20)))
                        .shadow(radius: 20)
                        .overlay {
                            Text("Mapa")
                                .padding()
                            
                                .font(.custom("Skia", size: 30))
                        }.position(x:UIScreen.main.bounds.midX/1.01,y:UIScreen.main.bounds.midY*1.3)
                    
                }
                
                
            }
        }
    }
}
struct TutorialPage3_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage3()
    }
}
extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 8) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))
        
        return self
            .overlay(
                shape
                    .stroke(color, lineWidth: width)
                    .offset(x: finalX * width * 0.3, y: finalY * width * 0.3)
                    .blur(radius: blur)
                    .mask(shape)
            )
    }
    
}


