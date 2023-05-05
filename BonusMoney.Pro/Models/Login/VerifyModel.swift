//
//  VerifyModel.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation


struct VerifyModel: Codable {
    var phone: String
    var token: String
    var customer: Customer?
    var inCompanyProfile: InCompanyProfile?
}

struct Customer: Codable {
    
}

struct InCompanyProfile: Codable {
    
}


struct VerifyCallToPhoneModelBadResponse: Decodable {
    var type: String
    var message: String
}
