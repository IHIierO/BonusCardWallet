//
//  CardModel.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation

struct CardModel: Codable {
    let company: CompanyID
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}

struct CompanyID: Codable {
    let companyId: String
}

struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

struct LoyaltyLevel: Codable {
    let number: Int
    let name: String
    let requiredSum: Int
    let markToCash: Int
    let cashToMark: Int
}

struct MobileAppDashboard: Codable {
   let companyName: String
   let logo: String
   let backgroundColor: String
   let mainColor: String
   let cardBackgroundColor: String
   let textColor: String
   let highlightTextColor: String
   let accentColor: String
}
