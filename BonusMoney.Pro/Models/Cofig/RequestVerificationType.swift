//
//  RequestVerificationType.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 17.05.2023.
//

import Foundation

enum RequestVerificationType: String {
    case callPass = "CALL_PASS"
    case sms = "SMS"
    case all
    case null = "null"
}
