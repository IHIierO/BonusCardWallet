//
//  AlertsModel.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 14.04.2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
}
