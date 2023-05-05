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
    
    func callNumber() {
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
    
    func requestPhoneVerification() {
        RequestManager.shared.requestPhoneVerification(for: phoneNumber) {[weak self] result in
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
