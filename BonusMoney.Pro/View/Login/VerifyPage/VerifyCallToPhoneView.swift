//
//  VerifyCallToPhoneView.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct VerifyCallToPhoneView: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    @EnvironmentObject var globalVariables: GlobalVariables
    
    @State private var wantContinue = false
    @State private var confirm = false
    @State private var goToProfilePage = false
    @State private var goToSMSConfirm = false
    @State private var getPhoneNumberConfirm = false
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                        Text("Позвоните на номер")
                            .font(.system(size: 24).bold())
                            .foregroundColor(Color(hex: Colors.mainText.rawValue))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                        
                        Text("Необходимо, чтобы подтвердить Вас")
                            .foregroundColor(Color(hex: Colors.secondText.rawValue))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding()
                
                
                FilledButton(title: "Позвонить", action: {
                    viewModel.verifyCallToNumber()
                }, color: Color.mainText, radius: Constants.btn_radius)
                .padding(.horizontal, Constants.large_double_margin)
                
                
                if globalVariables.requestVerificationType == .all {
                    NavigationLink(destination: VerifyRegistrationCodeView()
                        .environmentObject(viewModel), isActive: $goToSMSConfirm) {
                        Text("Запросить SMS")
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                
                Button {
                    viewModel.requestPhoneVerification(verificationType: .callPass)
                    print("Новый номер запрошен")
                } label: {
                    Text("Запросить номер для звонка")
                        .foregroundColor(.blue)
                }
                .padding()

                Spacer()
                
                FilledButton(title: "Продолжить", action: {
                    viewModel.getVerifyUser(code: nil)
                }, color: Color.activeElement, radius: Constants.btn_radius)
                .padding(.horizontal, Constants.large_double_margin)
                
            }
            
            //if viewModel.showAlert {
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
           // }
            
            NavigationLink(
                destination: ProfilePage(phone: viewModel.phoneNumber)
                    .environmentObject(globalVariables)
                , isActive: $goToProfilePage) {
                EmptyView()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("You can use some function")
                viewModel.getVerifyUser(code: nil)
            }
        }
    }
}

struct VerifyCallToPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var globalVariables = GlobalVariables()
        @ObservedObject var viewModel = LoginViewModel()
        VerifyCallToPhoneView()
            .environmentObject(viewModel)
            .environmentObject(globalVariables)
    }
}

