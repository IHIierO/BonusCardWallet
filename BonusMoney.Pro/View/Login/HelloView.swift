//
//  HelloView.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct HelloView: View {
    
    //@AppStorage("language")
   // private var language = BonusMoney_ProApp.config// LocalizationService.shared.language
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    @State private var isLoggedIn = false
    @State private var goToPhoneNumberPage = false
    @State private var chooseLanguage = false
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color.mainBackground
                        .ignoresSafeArea()
                    VStack {
                        /// Country menu
                        LocalizedMenu {
                            print("Choose alert")
                            chooseLanguage.toggle()
                        }
                        .frame(width: 260, height: 70)
                        .cornerRadius(Constants.logo_size)
                        .padding(.top, Constants.large_margin)
                        //.environmentObject(globalVariables)
                            
                        Spacer()
                        
                        /// Banner
                        Image("bm_banner")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, Constants.middle_margin)
                        
                        Spacer()
                        /// Hello Text
                        Text("""
                            Привет, Вы знаете,
                            где можно воспользоваться бонусами
                            от Bonus Money?
                            """)
                        .font(.system(size: Constants.large_text_size))
                        .foregroundColor(.mainText)
                        .padding(.horizontal, Constants.middle_margin)
                        
                        /// LoggIn buttons
                        HStack(spacing: Constants.middle_margin){
                            FilledButton(title: "Да", action: {
                                print("Yes button tap")
                                goToPhoneNumberPage = true
                            }, color: .activeElement, radius: Constants.btn_radius)
                            
                            FilledButton(title: "Нет", action: {
                                print("No button tap")
                                globalVariables.testShowAlert .toggle()
                            }, color: .secondText, radius: Constants.btn_radius)
                            
                            
                        }
                        .padding(.horizontal)
                    }
                   
                    
                    if globalVariables.testShowAlert  {
                        CustomAlert {
                            AlertWithTwoButtons(yesAction: {
                                globalVariables.testShowAlert  = false
                                goToPhoneNumberPage = true
                            }, noAction: {
                                globalVariables.testShowAlert  = false
                            }, alertTitle: "К сожалению, приложение Bonus Mone не показывает список всех компаний, где можно воспользоваться бонусами, скидками от Bonus Money. Скорее всего, оно будет бесполезное для Bac.", alertSubTitle: "Продолжить регистрацию?")
                        } closeAction: {
                            globalVariables.testShowAlert  = false
                        }
                    }
                    
                    if chooseLanguage {
                        CustomAlert {
                            LocalizationMenu {
                                chooseLanguage = false
                            }
                        } closeAction: {
                            chooseLanguage = false
                        }

                    }
                    
                    NavigationLink(destination: PhoneNumberPage(), isActive: $goToPhoneNumberPage) {
                        EmptyView()
                    }
                }
            }
    }
}

private extension HelloView {
    
    func countryFlag(_ countryCode: String) -> String {
      String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
        UnicodeScalar(127397 + $0.value)
      }))
    }
}

struct HelloView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var globalVariables = GlobalVariables()
        ContentView().environmentObject(globalVariables)
    }
}
