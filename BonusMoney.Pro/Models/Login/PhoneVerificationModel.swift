//
//  PhoneVerificationModel.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation

struct PhoneVerificationModel: Codable {
    var status: String
    var currentSendType: String
    var availableTypes: [AvailableTypes]
}

struct AvailableTypes: Codable {
    var type: String
    var timeSend: Int
    var nextSendIn: Int
    var callToPhone: String?
}
