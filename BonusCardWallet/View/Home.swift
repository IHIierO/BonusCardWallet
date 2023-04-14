//
//  Home.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel = CardViewViewModel()
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 1)
    var body: some View {
        VStack {
            HeaderView()
            ScrollView {
                LazyVGrid(columns: self.columns) {
                    ForEach(viewModel.cards, id: \.company.companyId) {card in
                        CardView(card: card)
                    }
                    .padding(.horizontal, 5)
                    .padding(10)
                    
                    if viewModel.isLoading {
                        HUDProgressView(placeHolder: "Подгрузка компаний", show: $viewModel.isLoading)
                            .padding(.top)
                            .onAppear(perform: viewModel.fetchData)
                    }
                }
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background {
                Color(hex: "efefef")
                    .ignoresSafeArea()
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
