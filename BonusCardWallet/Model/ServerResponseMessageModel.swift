//
//  ServerResponseMessageModel.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 14.04.2023.
//

import Foundation

struct ServerResponseMessageModel: Codable {
    let type: String
    let message: String
}
