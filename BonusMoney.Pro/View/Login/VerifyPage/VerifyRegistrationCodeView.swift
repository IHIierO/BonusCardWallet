//
//  ConfirmSMS.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct VerifyRegistrationCodeView: View {
    @StateObject var otpViewModel: OTPViewModel = .init()
    @EnvironmentObject var viewModel: LoginViewModel
    @EnvironmentObject var globalVariables: GlobalVariables
    
    @State private var goToProfilePage = false
    @FocusState private var focusItem: Bool
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                        Text("Введите 4 цифры из sms-сообщения")
                            .font(.system(size: 18).bold())
                            .foregroundColor(Color(hex: Colors.mainText.rawValue))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                        
                        Text("Необходимо, чтобы подтвердить Вас")
                            .foregroundColor(Color(hex: Colors.secondText.rawValue))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding()
                
              OTPTextField()
                    .focused($focusItem)
                    .environmentObject(otpViewModel)
                    .toolbar{
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                focusItem = false
                            }
                        }
                    }
                
                CountdownTimerView(duration: globalVariables.smsNextSendIn, text: "Запросить SMS")
                    .foregroundColor(.secondText)
                    .padding(.vertical)
                CountdownTimerView(duration: globalVariables.phoneNextSendIn, text: "Запросить номер для звонка")
                    .foregroundColor(.secondText)
                    .padding(.bottom)
                Spacer()
                
                FilledButton(title: "Продолжить", action: {
                    viewModel.getVerifyUser(code: otpViewModel.otpString)
                }, color: Color.activeElement, radius: Constants.btn_radius)
                .padding(.horizontal, Constants.large_double_margin)
                .disabled(otpViewModel.checkStates())
                .opacity(otpViewModel.checkStates() ? 0.4 : 1)
            }
            .ignoresSafeArea(.keyboard)
            
            if viewModel.showAlert {
                if let customAlert = viewModel.alertItem {
                    if customAlert.status == .error {
                        CustomAlert {
                            AlertWithOneButton(action: {
                                viewModel.showAlert = false
                            }, alertTitle: customAlert.message)
                        } closeAction: {
                            viewModel.showAlert = false
                        }

                    } else if customAlert.status == .complete {
                        CustomAlert {
                            AlertWithOneButton(action: {
                                viewModel.showAlert = false
                                goToProfilePage = true
                            }, alertTitle: customAlert.message)
                        } closeAction: {
                            viewModel.showAlert = false
                        }
                    }
                }
            }
            
            NavigationLink(destination: ProfilePage(), isActive: $goToProfilePage) {
                EmptyView()
            }
        }
        .onAppear {
            //viewModel.requestPhoneVerification(verificationType: .sms)
        }
    }
}

struct VerifyRegistrationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var viewModel = LoginViewModel()
        @ObservedObject var globalVariables = GlobalVariables()
        VerifyRegistrationCodeView()
            .environmentObject(viewModel)
            .environmentObject(globalVariables)
    }
}
