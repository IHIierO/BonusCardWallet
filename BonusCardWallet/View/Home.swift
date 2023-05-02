//
//  Home.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct Home: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CardViewViewModel()
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 1)
    
    @State var isPresenting = false
    @State private var offset: Int = 0
    
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
                                    .onAppear{
                                        viewModel.fetchData(offset: offset)
                                        offset += 5
                                        print("Offset: \(GetAllCardsService.shared.offsetX)")
                                        print("---------------")
                                        print("Limit: \(GetAllCardsService.shared.limitX)")
                                    }
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Выйти") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
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
