//
//  NotificationName.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 17.05.2023.
//

import Foundation

enum CustomNotificationName{
    
    case changedLanguage
    case changedUserProfile
    case changedUserToken
    case smsCodeReceived
    
    var notificationName: Notification.Name {
        switch self {
        case .changedLanguage:
            return Notification.Name("com.BonusMoney.Pro.changedLanguage")
        case .changedUserProfile:
            return Notification.Name("com.BonusMoney.Pro.changedUserProfile")
        case .changedUserToken:
            return Notification.Name("com.BonusMoney.Pro.changedUserToken")
        case .smsCodeReceived:
            return Notification.Name("com.BonusMoney.Pro.SMSCodeReceived")
        }
    }
    
    var appStorageName: String {
        switch self {
        case .changedLanguage:
            return "language"
        case .changedUserProfile:
            return "profile"
        case .changedUserToken:
            return "userToken"
        case .smsCodeReceived:
            return "smsCode"
        }
    }
}
