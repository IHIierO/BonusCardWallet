//
//  PhoneNumberTextField.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import SwiftUI
import Combine

struct PhoneNumberField: View {
    @Binding var phoneNumber: String
    
    var body: some View {
        TextField("+7 (___) ___-__-__", text: $phoneNumber)
            .keyboardType(.numberPad)
            .onChange(of: phoneNumber, perform: { value in
                phoneNumber = format(phoneNumber: value)
            })
    }
    
    func format(phoneNumber: String) -> String {
        var formattedNumber = ""
        let digitsOnly = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = digitsOnly.count
        
        if length > 0 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(1, length-1))
            formattedNumber.append("+7 (")
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 1 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(2, length-1))
            formattedNumber.append(digitsOnly[startIndex])
            formattedNumber.append(") ")
        }
        
        if length > 3 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(4, length-1))
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 4 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(5, length-1))
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 5 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(6, length-1))
            formattedNumber.append(digitsOnly[startIndex])
            formattedNumber.append("-")
        }
        
        if length > 6 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(7, length-1))
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 7 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(8, length-1))
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 8 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(9, length-1))
            formattedNumber.append("-")
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 9 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(10, length-1))
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 10 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(11, length-1))
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        if length > 11 {
            let startIndex = digitsOnly.index(digitsOnly.startIndex, offsetBy: min(12, length-1))
            formattedNumber.append("-")
            formattedNumber.append(digitsOnly[startIndex])
        }
        
        return formattedNumber
    }

}




