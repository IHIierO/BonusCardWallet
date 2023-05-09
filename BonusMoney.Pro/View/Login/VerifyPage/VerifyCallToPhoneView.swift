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
                
                
                Button {
                    print("Button pressed")
//                    confirm.toggle()
                    viewModel.verifyCallToNumber()
                } label: {
                    Text("Позвонить")
                        .foregroundColor(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 40, alignment: .center)
                                .overlay {
                                    Color(hex: Colors.mainText.rawValue)
                                        .cornerRadius(10)
                                }
                        }
                }
                .padding()
                .padding(.top, 40)
                
                if globalVariables.requestVerificationType == .all {
                    
                    NavigationLink(destination: VerifyRegistrationCodeView(), isActive: $goToSMSConfirm) {
                        Text("Запросить SMS")
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                
                Button {
                    viewModel.requestPhoneVerification()
                    print("Новый номер запрошен")
                } label: {
                    Text("Запросить номер для звонка")
                        .foregroundColor(.blue)
                }
                .padding()

                Spacer()
                
                Button {
                    print("Button pressed")
                    viewModel.getVerifyUser()
                } label: {
                    Text("Продолжить")
                        .foregroundColor(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 40, alignment: .center)
                        }
                        .frame(width: 200, height: 40)
                }
            }
            .onAppear{
                //viewModel.requestPhoneVerification()
            }
            
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
