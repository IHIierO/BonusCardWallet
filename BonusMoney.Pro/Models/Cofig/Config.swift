//
//  Config.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI


final class GlobalVariables: ObservableObject {
    
    static let shared = GlobalVariables()
 
   @Published var globalLanguage = LocalizationService.shared.language
    
    enum RequestVerificationType: String {
        case callPass = "CALL_PASS"
        case sms = "SMS"
        case all
        case null = "null"
    }
    
    @Published var requestVerificationType: RequestVerificationType = .null
    @Published var phoneNextSendIn: Int = 0
    @Published var smsNextSendIn: Int = 0
}

