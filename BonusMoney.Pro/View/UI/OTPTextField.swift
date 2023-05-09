//
//  OTPTextField.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 09.05.2023.
//

import SwiftUI

struct OTPTextField: View {
    
    @EnvironmentObject var otpViewModel: OTPViewModel
    @FocusState var activeField: OTPField?
    
    var body: some View {
        HStack(spacing: Constants.middle_margin) {
            ForEach(0..<4, id: \.self) { index in
                VStack(spacing: Constants.middle_half_margin) {
                    TextField("", text: $otpViewModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: otpViewModel.activeStateForIndex(index: index))
                    
                    Rectangle()
                        .fill(activeField == otpViewModel.activeStateForIndex(index: index) ? Color.mainText : Color.secondText)
                        .frame(height: Constants.small_half_margin)
                }
                .frame(width: Constants.button_height)
            }
        }
        .onChange(of: otpViewModel.otpFields) { newValue in
            otpCondition(value: newValue)
        }
    }
    
    func otpCondition(value: [String]) {
        
        for index in 0..<4 {
            if value[index].count == 4 {
                DispatchQueue.main.async {
                    otpViewModel.otpString = value[index]
                    otpViewModel.otpFields[index] = ""
                    
                    for item in otpViewModel.otpString.enumerated() {
                        otpViewModel.otpFields[item.offset] = String(item.element)
                    }
                }
                return
            }
        }
        
        
        for index in 0..<3 {
            if value[index].count == 1 && otpViewModel.activeStateForIndex(index: index) == activeField{
                activeField = otpViewModel.activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...3 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = otpViewModel.activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0..<4 {
            if value[index].count > 1 {
                guard let lastValue = value[index].last else {return}
                otpViewModel.otpFields[index] = String(lastValue)
            }
        }
    }
}

struct OTPTextField_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var otpViewModel: OTPViewModel = .init()
        OTPTextField()
            .environmentObject(otpViewModel)
    }
}
