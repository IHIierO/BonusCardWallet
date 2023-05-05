//
//  AlertWithOneButton.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct AlertWithOneButton: View {
    
    let action: () -> Void
    var alertTitle = ""
    var alertSubTitle = ""
    
    init(action: @escaping () -> Void, alertTitle: String = "", alertSubTitle: String = "") {
        self.action = action
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
            
                FilledButton(title: "Да", action: {
                    print("Yes button tap")
                    action()
                }, color: .activeElement, radius: Constants.btn_radius)
                
            .padding(.horizontal)
        }
        .padding()
    }
}

struct RegistrationAlert_Previews: PreviewProvider {
    static var previews: some View {
        AlertWithOneButton(action: {})
    }
}
