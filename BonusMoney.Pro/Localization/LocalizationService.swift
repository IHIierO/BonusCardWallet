//
//  LocalizationService.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import Foundation

class LocalizationService {

    static let shared = LocalizationService()

    private init() {}
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: CustomNotificationName.changedLanguage.appStorageName) else {
                return .russian
            }
            return Language(rawValue: languageString) ?? .russian
        } set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: CustomNotificationName.changedLanguage.appStorageName)
                NotificationCenter.default.post(name: CustomNotificationName.changedLanguage.notificationName, object: nil)
            }
        }
    }
    
    let replacementChar: Character = "X"
}
