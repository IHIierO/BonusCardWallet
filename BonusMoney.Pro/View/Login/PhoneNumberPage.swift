//
//  PhoneNumberPage.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct PhoneNumberPage: View {
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focusItem: Bool
    
    @State private var wantContinue = false
    @State private var goToPhoneNumberPage = false
    @State private var chooseLanguage = false
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Введите номер телефона")
                            .font(.system(size: Constants.large_more_text_size).bold())
                            .foregroundColor(Color(hex: Colors.mainText.rawValue))
                            .padding()
                        
                        Text("Чтобы создать аккаунт и войти")
                            .font(.system(size: Constants.middle_more_text_size))
                            .foregroundColor(Color(hex: Colors.secondText.rawValue))
                            .padding(.leading)
                    }
                    
                    TextField(text: Binding(
                        get: { (viewModel.phoneNumber) },
                        set: { viewModel.phoneNumber = $0.applyingMask(globalVariables.globalLanguage.phoneNumberMask, replacementCharacter: LocalizationService.shared.replacementChar) }
                    ), label: {
                        Text("+7")
                            .foregroundColor(Color.secondText)
                    })
                        .padding(.horizontal)
                        .padding(.top)
                        .foregroundColor(Color(hex: Colors.mainText.rawValue))
                        .onSubmit{
                            focusItem = true
                        }
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                        .focused($focusItem)
                        .toolbar{
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    focusItem = false
                                }
                            }
                        }
                        .onSubmit {
                            viewModel.updatePhoneNumber()
                        }
//                        .onChange(of: viewModel.phoneNumber) { newValue in
//                            if newValue.count > 17 {
//                                viewModel.phoneNumber = String(newValue.prefix(18))
//                                focusItem = false
//                                print("Phone Number: \(viewModel.phoneNumber)")
//                            }
//                        }
                        
                    Divider()
                        .overlay(Color(hex: Colors.mainText.rawValue))
                        .padding(.horizontal)
                }
               
                /// Country menu
                LocalizedMenu {
                    print("Choose alert")
                    chooseLanguage.toggle()
                }
                .frame(width: 260, height: 70)
                .cornerRadius(Constants.logo_size)
                .padding(.top, Constants.large_margin)
                .environmentObject(globalVariables)
                
                Spacer()
                
                FilledButton(title: "Продолжить", action: {
                    viewModel.requestPhoneVerification()
                    wantContinue.toggle()
                }, color: Color.activeElement, radius: Constants.btn_radius)
                .padding(.horizontal, Constants.large_margin)
                .disabled(viewModel.validate())
                .opacity(viewModel.validate() ? 0.4 : 1)
                
            }
            
            if wantContinue {
                CustomAlert {
                    AlertWithOneButton(action: {
                        wantContinue = false
                        goToPhoneNumberPage.toggle()
                    }, alertTitle: "Вы подтверждаете, что номер \(viewModel.phoneNumber) принадлежит Вам, и Вы сможете подтвердить его?")
                } closeAction: {
                    wantContinue = false
                }
            }
            
            
            if chooseLanguage {
                CustomAlert {
                    LocalizationMenu {
                        chooseLanguage = false
                    }
                    .environmentObject(globalVariables)
                } closeAction: {
                    chooseLanguage = false
                }
            }
            
            NavigationLink(destination: VerifyPage()
                .environmentObject(viewModel)
                .environmentObject(globalVariables)
                , isActive: $goToPhoneNumberPage) {
                EmptyView()
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PhoneNumberPage_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var globalVariables = GlobalVariables()
        PhoneNumberPage().environmentObject(globalVariables)
    }
}
