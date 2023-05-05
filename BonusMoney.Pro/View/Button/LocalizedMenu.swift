//
//  LocalizedMenu.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import SwiftUI

struct LocalizedMenu: View {
//    @AppStorage("language")
//    private var language = LocalizationService.shared.language
    @EnvironmentObject var globalVariables: GlobalVariables
    
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Color.secondText
                .ignoresSafeArea()
                Button {
                    action()
                } label: {
                    HStack(spacing: 10) {
                        Image(globalVariables.globalLanguage.countryFlag)
                            .resizable()
                            .frame(width: Constants.logo_size, height: Constants.logo_size, alignment: .center)
                            .frame(maxWidth: .infinity)
                        
                        Text(globalVariables.globalLanguage.countryName)
                            .foregroundColor(.black)
                            .font(.system(size: Constants.middle_text_size))
                            .frame(maxWidth: .infinity)
                        Image("arrow_back")
                            .resizable()
                            .renderingMode(.template)
                            .rotationEffect(.degrees(-90))
                            .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                            .foregroundColor(.mainText)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
            
        }
    }
}

struct LocalizedMenu_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var globalVariables = GlobalVariables()
        LocalizedMenu(action: {}).environmentObject(globalVariables)
    }
}
