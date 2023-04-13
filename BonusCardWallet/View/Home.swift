//
//  Home.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct Home: View {
    @State private var results = ["one","two"]
    var body: some View {
        VStack {
            HeaderView()
            List(results, id: \.self) {item in
                CardView()
            }
            .onAppear{
                GetAllCardsService.shared.getAllCards()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Color(hex: "efefef")
                .ignoresSafeArea()
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xs Max")
        ContentView().previewDevice("iPhone 8")
    }
}
