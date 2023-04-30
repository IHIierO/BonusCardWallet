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
    
    @State var isPresenting = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                    Button("SQLiteDB") {
                        isPresenting = true
                    }
                    .padding()
                ScrollView {
                    LazyVGrid(columns: self.columns) {
                        Section(content: {
                            ForEach(viewModel.cards, id: \.company.companyId) {card in
                                CardView(card: card).environmentObject(viewModel)
                            }
                            .padding(.horizontal, 5)
                        .padding(10)
                        }, footer: {
                            if viewModel.isLoading {
                                HUDProgressView(placeHolder: "Подгрузка компаний", show: $viewModel.isLoading)
                                    .padding(.top)
                                    .onAppear(perform:
                                                viewModel.fetchData
                                    )
                           }

                        })
                        
                    }
                    .alert(item: $viewModel.alertItem) { item in
                        Alert(title: item.title,
                                          message: item.message)
                            }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Color(hex: "efefef")
                        .ignoresSafeArea()
                }
                
                NavigationLink(destination: Test_DB_Manager().environmentObject(viewModel), isActive: $isPresenting) { EmptyView() }
            }
            .navigationBarTitle("Управление картами")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xs Max")
        ContentView().previewDevice("iPhone Xs")
    }
}
