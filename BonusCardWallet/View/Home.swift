//
//  Home.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct Home: View {
    @State private var cards: [CardModel] = []
    @State private var isLoading = false
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                List(cards, id: \.company.companyId) {card in
                    CardView(card: card)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .onAppear{
                    isLoading = true
                    RequestsFactory.shared.createRequest(for: .getAllCompaniesLong) { result in
                        switch result {
                        case .success(let cards):
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.cards = cards
                            }
                            print("Cards: \(cards)")
                        case .failure(let error):
                            print("Error: \(String(describing: error))")
                        }
                    }
                }
                .listStyle(.grouped)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background {
                Color(hex: "efefef")
                    .ignoresSafeArea()
            }
            if isLoading { HUDProgressView(placeHolder: "Please Wait", show: $isLoading)
                    .padding(100)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xs Max")
        ContentView().previewDevice("iPhone 8")
    }
}
