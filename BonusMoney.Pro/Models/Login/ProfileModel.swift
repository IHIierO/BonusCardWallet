//
//  ProfileModel.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct ProfileModel: Codable {
    var first_name: String
    var patronymic: String
    var last_name: String
    var gift: String
    var gender: String
    var phone: String
    var mail: String
}

enum UserTextFieldLogo: String, CaseIterable{
    case first_name = "first_name"
    case patronymic = "patronymic"
    case last_name = "last_name"
    case gift = "gift"
    case gender = "gender"
    case phone = "phone"
    case mail = "mail"
    
    var textfieldPlaceholder: String {
        switch self {
        case .first_name:
            return "Введите Имя"
        case .patronymic:
            return "Введите Отчество"
        case .last_name:
            return "Введите Фамилию"
        case .gift:
            return "Укажите дату рождения"
        case .gender:
            return "Укажите пол"
        case .phone:
            return "Введите номер телефона"
        case .mail:
            return "Введите почту"
        }
    }
    
    var image: Image {
               return Image(self.rawValue)
           }
}
