//
//  AlertWithTwoButtons.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct AlertWithTwoButtons: View {
    
    let yesAction: () -> Void
    let noAction: () -> Void
    var alertTitle = ""
    var alertSubTitle = ""
    
    init(yesAction: @escaping () -> Void, noAction: @escaping () -> Void, alertTitle: String = "", alertSubTitle: String = "") {
        self.yesAction = yesAction
        self.noAction = noAction
        self.alertTitle = alertTitle
        self.alertSubTitle = alertSubTitle
    }
    
    var body: some View {
        VStack {
            Text(alertTitle)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.mainText)
            
            Text(alertSubTitle)
                .foregroundColor(.mainText)
            
            HStack(spacing: Constants.middle_margin){
                FilledButton(title: "Да", action: {
                    print("Yes button tap")
                    yesAction()
                }, color: .activeElement, radius: Constants.btn_radius)
                
                FilledButton(title: "Нет", action: {
                    print("No button tap")
                    noAction()
                }, color: .secondText, radius: Constants.btn_radius)
                
                
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct AlertWithTwoButtons_Previews: PreviewProvider {
    static var previews: some View {
        AlertWithTwoButtons(yesAction: {}, noAction: {})
    }
}
