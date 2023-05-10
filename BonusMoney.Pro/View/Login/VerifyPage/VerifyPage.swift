//
//  VerifyPage.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 08.05.2023.
//

import SwiftUI

struct VerifyPage: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        
        ZStack {
            
            if globalVariables.requestVerificationType == .callPass || globalVariables.requestVerificationType == .all {
                VerifyCallToPhoneView()
                    .environmentObject(globalVariables)
            } else if globalVariables.requestVerificationType == .sms {
                VerifyRegistrationCodeView()
            } else if globalVariables.requestVerificationType == .null{
                ProgressView()
                    .background {
                        Color.mainBackground
                            .ignoresSafeArea()
                    }
            }
            
        }
        .onAppear {
            viewModel.checkAvailableTypes()
            print("Type in VerifyPage: \(globalVariables.requestVerificationType)")
        }
    }
}

struct VerifyPage_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var globalVariables = GlobalVariables()
        @ObservedObject var viewModel = LoginViewModel()
        VerifyPage()
            .environmentObject(viewModel)
            .environmentObject(globalVariables)
    }
}
