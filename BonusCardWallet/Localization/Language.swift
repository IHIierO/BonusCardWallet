//
//  Language.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 28.04.2023.
//

import Foundation

enum Language: String {
    case russian = "ru"
    case english_us = "en"
    
    var userSymbol: String {
            switch self {
            case .english_us:
                return "us"
            default:
                return rawValue
            }
        }
}
