//
//  Alert.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import SwiftUI

struct Alert: View {
    
    @Binding var show: Bool
//    @Binding var goToNextPage: Bool
   // @Binding var bakgroundColor: Color
    
    @State var alertTitle = ""
    @State var alertSubTitle = ""
    @State private var language = Language.allCases
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
               
                List {
                    Section("Выберите страну") {
                        ForEach(language, id: \.self) { language in
                            
                            Button {
                                print("Tapped")
                                LocalizationService.shared.language = language
                                show.toggle()
                            } label: {
                                HStack(spacing: 10){
                                    Image(language.countryFlag)
                                        .resizable()
                                        .frame(width: Constants.logo_size, height: Constants.logo_size, alignment: .center)
                                        
                                    
                                    Text(language.countryName)
                                        .foregroundColor(.black)
                                        .font(.system(size: Constants.middle_text_size))
                                        
                                }
                            }
                        }
                    }
                    
                    
                }
                .frame(minWidth: .ulpOfOne, idealWidth: 300, maxHeight: CGFloat(language.count) * 84, alignment: .center)
                .cornerRadius(Constants.btn_radius)
                .listRowSeparator(.hidden)
                .padding(.horizontal, Constants.large_margin)
                
                Spacer()
                
                Button {
                    print("Alert close")
                    show.toggle()
                } label: {
                    Text("X")
                        .foregroundColor(Color(hex: Colors.mainText.rawValue))
                        .background {
                            Color(.white)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                        }
                }
                .padding(.bottom, Constants.large_margin)
            }
            
        }
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        @State var show = false
        Alert(show: $show)
    }
}


//                        Menu {
//                            Button {
//                                LocalizationService.shared.language = .russian
//                            } label: {
//                                HStack {
//                                    Text("Русский" + " " + countryFlag("RU"))
//                                }
//                            }
//                            Button {
//                                LocalizationService.shared.language = .kz
//                            } label: {
//                                Text("Казахский" + " " + countryFlag("KZ"))
//                            }
//                        } label: {
//                            VStack {
//                                HStack(spacing: 10){
//                                    Image(language.countryFlag)
//                                        .resizable()
//                                        .frame(width: Constants.middle_icon_size, height: Constants.middle_icon_size, alignment: .center)
//
//                                    Text(language.countryName)
//                                        .foregroundColor(.black)
//                                        .font(.system(size: Constants.middle_text_size))
//                                }
//                                .padding(.bottom, 10)
//
//                                Divider()
//                            }
//                        }
//                        .frame(width: 150, height: 60, alignment: .center)
//                        .padding(.top, Constants.large_margin)
