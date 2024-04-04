//
//  ContactUsView.swift
//  Songo
//
//  Created by Amanda Melo on 22/03/24.
//

import SwiftUI

struct ContactUsView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(uiColor: UIColor.fundo),lineWidth: 1)
                    Text("We are excited that you're exploring how music can keep memories from where you've been! To help us improve your experience, please send us a message with new ideas or any issue you might be having!")
                        .font(Font.custom("FiraSans-Regular", size: UIScreen.current.bounds.width/24.4))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.current.bounds.width/1.2,alignment: .center)
                }
                .frame(height: UIScreen.current.bounds.height/5.8)
                .padding(.horizontal, UIScreen.current.bounds.width/22)
                
                Button {
                    if let url = URL(string: "mailto:contactsoundmap@gmail.com") {
                                openURL(url)
                        }
                } label: {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color(uiColor: UIColor.fundo))
                            Text("Send an E-mail")
                                .font(Font.custom("FiraSans-SemiBold", size: UIScreen.current.bounds.width/30))
                                .foregroundStyle(.white)
                        }
                        .frame(width: UIScreen.current.bounds.width/1.33, height: UIScreen.current.bounds.height/23)
//                                            Text("contactsoundmap@gmail.com")
                    }
                }
                .padding(.top, UIScreen.current.bounds.height/70)
                Button {
                    if let url = URL(string: "https://www.instagram.com/exploresoundmap?igsh=ZzEwZm04d3I5endn") {
                                openURL(url)
                        }

                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color(uiColor: UIColor.fundo))
                        Text("Follow on Instagram")
                            .font(Font.custom("FiraSans-SemiBold", size: UIScreen.current.bounds.width/30))
                            .foregroundStyle(.white)
                    }
                    .frame(width: UIScreen.current.bounds.width/1.33, height: UIScreen.current.bounds.height/23)
                }

            }
            .padding(.bottom, UIScreen.current.bounds.height/2.1)
            .toolbarBackground(Color(uiColor: UIColor.fundoPlaylist))
            .toolbarBackground(.visible)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Contact Us")
                        .font(Font.custom("FiraSans-Bold", size: UIScreen.current.bounds.width/15))
                        .foregroundStyle(.white)
                        .padding(.top, UIScreen.current.bounds.height/9)
                    
                    
                }
            }
        }
    }
}
