//
//  AlertModel.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import SwiftUI

struct AlertModel: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let status: AlertStatus
}

enum AlertStatus {
    case complete
    case error
}
