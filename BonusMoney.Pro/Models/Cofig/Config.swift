//
//  Config.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI

final class GlobalVariables: ObservableObject {
    
    @AppStorage(CustomNotificationName.changedLanguage.appStorageName) var globalLanguage = LocalizationService.shared.language
    @AppStorage(CustomNotificationName.changedUserProfile.appStorageName) var userProfile: Data?
    @AppStorage(CustomNotificationName.changedUserToken.appStorageName) var userToken: String = ""
    
    @Published var requestVerificationType: RequestVerificationType = .null
    
    @Published var phoneNextSendIn: Int = 0
    @Published var smsNextSendIn: Int = 0
}

