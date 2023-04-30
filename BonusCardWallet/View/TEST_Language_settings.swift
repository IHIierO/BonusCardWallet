//
//  TEST_Language_settings.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 28.04.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("settings_language".localized(language))
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                Menu {
                    Button {
                        LocalizationService.shared.language = .russian
                    } label: {
                        Text("Русский")
                        Text(countryFlag("RU"))
                    }
                    Button {
                        LocalizationService.shared.language = .english_us
                    } label: {
                        Text("English (US)")
                        Text(countryFlag("US"))
                    }
                } label: {
                    Spacer()
                    Text(countryFlag(language.userSymbol.uppercased()))
                }.padding()
            }
            Text("settings_language_footer".localized(language))
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.leading)
            Spacer()
        }
        .background(Color.black)
    }
}


private extension SettingsView {
    
    func countryFlag(_ countryCode: String) -> String {
      String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
        UnicodeScalar(127397 + $0.value)
      }))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
