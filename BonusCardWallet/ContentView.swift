//
//  ContentView.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xs Max")
        ContentView().previewDevice("iPhone 8")
    }
}
