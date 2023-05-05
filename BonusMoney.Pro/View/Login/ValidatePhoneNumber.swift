//
//  ValidatePhoneNumber.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct ValidatePhoneNumber: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    
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
                    viewModel.callNumber()
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
                
                NavigationLink(destination: ConfirmSMS(), isActive: $goToSMSConfirm) {
                    Text("Запросить SMS")
                        .foregroundColor(.blue)
                }
                .padding()
                
                NavigationLink(destination: Text("Second view"), isActive: $getPhoneNumberConfirm) {
                    Text("Запросить номер для звонка")
                        .foregroundColor(.blue)
                }
                
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
                viewModel.requestPhoneVerification()
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

struct ValidatePhoneNumber_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var viewModel = LoginViewModel()
        ValidatePhoneNumber().environmentObject(viewModel)
    }
}

