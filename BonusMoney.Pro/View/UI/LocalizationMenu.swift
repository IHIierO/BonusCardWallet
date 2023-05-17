//
//  LocalizationMenu.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI

struct LocalizationMenu: View {
    @State private var language = Language.allCases
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        List {
            Section {
                ForEach(language, id: \.self) { language in
                    
                    Button {
                        
                        globalVariables.globalLanguage = language
                        print("Global language: \(globalVariables.globalLanguage)")
                        action()
                    } label: {
                        HStack(spacing: 10){
                            Image(language.countryFlag)
                                .resizable()
                                .frame(width: Constants.logo_size, height: Constants.logo_size, alignment: .center)
                                
                            
                            Text(language.countryName)
                                .foregroundColor(Color.mainText)
                                .font(.system(size: Constants.middle_text_size))
                                
                        }
                    }
                }
            } header: {
                Text("Выберете страну")
                    .foregroundColor(Color.secondText)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .cornerRadius(Constants.btn_radius)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.elementsBackground)
        .frame(minWidth: .ulpOfOne, idealWidth: 300, maxHeight: CGFloat(language.count) * 84, alignment: .center)
        .cornerRadius(Constants.btn_radius)
        
    }
}

struct LocalizationMenu_Previews: PreviewProvider {
    static var previews: some View {
        LocalizationMenu(action: {})
    }
}
