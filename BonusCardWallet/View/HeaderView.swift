//
//  HeaderView.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("Управление картами")
            .font(.system(size: 24))
            .foregroundColor(Color(hex: "2688eb"))
            .frame(maxWidth: .infinity)
            .background {
                Color(hex: "ffffff")
            }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
