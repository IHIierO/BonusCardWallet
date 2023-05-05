//
//  Config.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI


final class GlobalVariables: ObservableObject {
   @Published var globalLanguage = LocalizationService.shared.language
   @Published var testShowAlert: Bool = false
}

