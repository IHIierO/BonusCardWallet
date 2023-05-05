//
//  Language.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import Foundation

enum Language: String, CaseIterable {
    case russian = "ru"
    case kz = "kz"
    
    var countryName: String {
        switch self {
        case .russian:
           return "Россия"
        case .kz:
           return "Казахстан"
        }
    }
    
    var countryFlag: String {
        switch self {
        case .russian:
           return "rus"
        case .kz:
           return "kz"
        }
    }

}
