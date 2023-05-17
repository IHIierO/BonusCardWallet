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
    
    func updatePhoneNumber(for mask: String) {
        if phoneNumber.count > mask.count {
            phoneNumber.removeSubrange(phoneNumber.index(phoneNumber.startIndex, offsetBy: mask.count)...)
            }
        }
    
    func validate() -> Bool {
                let PHONE_REGEX = "^\\+7 \\(\\d{3}\\) \\d{3}-\\d{2}-\\d{2}$"
                let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
                let result = phoneTest.evaluate(with: phoneNumber)
                return !result
            }
    
    func checkAvailableTypes(using globalVariables: GlobalVariables) {
            guard let currentModel = phoneVerificationModel else {return}
            let availableTypes = currentModel.availableTypes
            if availableTypes.count == 0 {
                globalVariables.requestVerificationType = .null
            } else if availableTypes.count == 1 {
                if availableTypes[0].type == "CALL_PASS" {
                    globalVariables.requestVerificationType = .callPass
                    globalVariables.phoneNextSendIn = availableTypes[0].nextSendIn
                } else if availableTypes[0].type == "SMS" {
                    globalVariables.requestVerificationType = .sms
                    globalVariables.smsNextSendIn = availableTypes[0].nextSendIn
                }
            } else if availableTypes.count == 2 {
                let firstType = availableTypes[0]
                let secondType = availableTypes[1]
                if firstType.type == "CALL_PASS" && secondType.type == "SMS" {
                    globalVariables.requestVerificationType = .all
                    globalVariables.phoneNextSendIn = firstType.nextSendIn
                    globalVariables.smsNextSendIn = secondType.nextSendIn
                } else if firstType.type == "SMS" && secondType.type == "CALL_PASS" {
                    globalVariables.requestVerificationType = .all
                    globalVariables.smsNextSendIn = firstType.nextSendIn
                    globalVariables.phoneNextSendIn = secondType.nextSendIn
                }
            }
            print("Type in VM: \(globalVariables.requestVerificationType)")
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
    
    func requestPhoneVerification(verificationType: RequestVerificationType = .null) {
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
    
    func getVerifyUser(code: String?) {
        guard let currentModel = phoneVerificationModel else {return}
        
        let completionHandler: (Result<VerifyModel, NetworkError>) -> Void = { [weak self] result in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    strongSelf.verifyUser = result
                    strongSelf.showAlert = true
                    strongSelf.alertItem = AlertModel(title: "", message: "Мы нашли аккаунт, который был привязан к номеру телефона: \(result.phone). Оставить данные профиля, которые были указаны ранее или ввести их заново?", status: .complete)
                    strongSelf.saveUserToken(token: result.token)
                    print("Verify User: \(result)")
                case .failure(let error):
                    strongSelf.showAlert = true
                    strongSelf.alertItem = AlertModel(title: "", message: String(describing: error.localizedDescription), status: .error)
                    print("Request Phone Verification Error: \(error.localizedDescription)")
                }
            }
        }
        
        if currentModel.currentSendType == "CALL_PASS" {
            let currentSendType = currentModel.currentSendType
            
            guard let number = currentModel.availableTypes.first(where: {$0.type == currentSendType})?.callToPhone else {return}
            
            let cleanNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
            
            RequestManager.shared.verifyCallToPhone(from: phoneNumber, to: cleanNumber, completion: completionHandler)
        } else if currentModel.currentSendType == "SMS"{
            guard let code = code else {return}
            RequestManager.shared.verifyRegistrationCode(from: phoneNumber, code: code, completion: completionHandler)
        }
    }
    
    func saveUserToken(token: String){
        UserDefaults.standard.setValue(token, forKey: CustomNotificationName.changedUserToken.appStorageName)
        NotificationCenter.default.post(name: CustomNotificationName.changedUserToken.notificationName, object: nil)
    }
}
