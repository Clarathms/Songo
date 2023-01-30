//
//  OnBoardingModel.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import Foundation

class OnBoardingModel {

    var currentPage = 0
    var onBoardingItems: [OnBoardingItem] = [
        OnBoardingItem(imageName: "OnBoarding-1",
                       title: NSLocalizedString("Seja bem-vindo ao Cogu!", comment: "OnBoardingModel: Title for the first page of OnBoardig Screen."),
                       message: NSLocalizedString("Aqui você consegue deixar a sua marca no mundo por onde você passar.", comment: "OnBoardingModel: Message for the first page of OnBoarding Screen.")),
        OnBoardingItem(imageName: "OnBoarding-2",
                       title: NSLocalizedString("Crie cogus", comment: "OnBoardingModel: Title for the second page of OnBoardig Screen."),
                       message: NSLocalizedString("Cogus são GIFs e músicas que você coloca onde estiver para que todos por ali possam coletar e colecionar.", comment: "OnBoardingModel: Message for the second page of OnBoarding Screen.")),
        OnBoardingItem(imageName: "OnBoarding-3",
                       title: NSLocalizedString("Colecione cogus", comment: "OnBoardingModel: Title for the third page of OnBoardig Screen."),
                       message: NSLocalizedString("Há vários cogus pelo mapa! Para colecionar ou publicar cogus é preciso que você faça login e compartilhe sua localização.", comment: "OnBoardingModel: Message for the third page of OnBoarding Screen."))
    ]
}
struct OnBoardingItem {
    var imageName: String
    var title: String
    var message: String
}
