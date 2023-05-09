//
//  LoginViewModel.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var phoneNumber = ""
    @Published var phoneVerificationModel: PhoneVerificationModel?
    @Published var alertItem: AlertModel?
    @Published var verifyUser: VerifyModel?
    @Published var showAlert = false
    
    func validate() -> Bool {
        print("PhoneNumber: \(phoneNumber)")
                let PHONE_REGEX = "^\\+7 \\(\\d{3}\\) \\d{3}-\\d{2}-\\d{2}$"
                let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
                let result = phoneTest.evaluate(with: phoneNumber)
        print("Result: \(result)")
                return !result
            }
    
    func checkAvailableTypes() {
        guard let currentModel = phoneVerificationModel else {return}
        let availableTypes = currentModel.availableTypes
        if availableTypes.count == 0 {
            GlobalVariables.shared.requestVerificationType = .null
        }else if availableTypes.count == 1 {
            if availableTypes[0].type == "CALL_PASS" {
                GlobalVariables.shared.requestVerificationType = .callPass
            } else if availableTypes[0].type == "SMS" {
                GlobalVariables.shared.requestVerificationType = .sms
            }
        } else if availableTypes.count == 2 {
            let firstType = availableTypes[0].type
            let secondType = availableTypes[1].type
            if firstType == "CALL_PASS" && secondType == "SMS" {
                GlobalVariables.shared.requestVerificationType = .all
            } else if firstType == "SMS" && secondType == "CALL_PASS" {
                GlobalVariables.shared.requestVerificationType = .all
            }
        }
        print("Type in VM: \(GlobalVariables.shared.requestVerificationType)")
    }
    
    func verifyCallToNumber() {
        guard let currentModel = phoneVerificationModel else {return}
        
        let currentSendType = currentModel.currentSendType
        
        guard let number = currentModel.availableTypes.first(where: {$0.type == currentSendType})?.callToPhone else {return}
        
        let cleanNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        print("Phone number to call: \(cleanNumber)")
        guard let url = URL(string: "telprompt://\(cleanNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func requestPhoneVerification(verificationType: GlobalVariables.RequestVerificationType = .null) {
        RequestManager.shared.requestPhoneVerification(for: phoneNumber, verificationType: verificationType) {[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    strongSelf.phoneVerificationModel = result
                }
            case .failure(let error):
                print("Request Phone Verification Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getVerifyUser() {
        guard let currentModel = phoneVerificationModel else {return}
        
        let currentSendType = currentModel.currentSendType
        
        guard let number = currentModel.availableTypes.first(where: {$0.type == currentSendType})?.callToPhone else {return}
        
        let cleanNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        RequestManager.shared.verifyCallToPhone(from: phoneNumber, to: cleanNumber) {[weak self] result in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    
                    strongSelf.verifyUser = result
                    strongSelf.showAlert = true
                    strongSelf.alertItem = AlertModel(title: "", message: "Мы нашли аккаунт, который был привязан к номеру телефона: \(result.phone). Оставить данные профиля, которые были указаны ранее или ввести их заново?", status: .complete)
                    print("Verify User: \(result)")
                case .failure(let error):
                    strongSelf.showAlert = true
                    strongSelf.alertItem = AlertModel(title: "", message: String(describing: error.localizedDescription), status: .error)
                    print("Request Phone Verification Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
