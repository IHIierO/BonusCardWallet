//
//  OTPViewModel.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 09.05.2023.
//

import SwiftUI

final class OTPViewModel: ObservableObject {
    @Published var otpString: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 4)
    
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        default: return .field4
        }
    }
    
    func checkStates() -> Bool {
        for index in 0..<4 {
            if otpFields[index].isEmpty {return true}
        }
        return false
    }
    
}

enum OTPField {
    case field1
    case field2
    case field3
    case field4
}
