//
//  CardViewViewModel.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation
import SwiftUI

enum MyAlerts {
    case yey
    case trash
    case moreDetails
}

final class CardViewViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var isLoading = true
    
    @Published var showAlert: Bool = false
    @Published var alertType: MyAlerts? = nil
    @Published var responseError: ResponseError? = nil
    
    func getAlert(message: String) -> Alert {
        switch alertType {
        case .yey:
            return Alert(title: Text("Yey button pressed"), message: Text("Company Id: \(message)"))
        case .trash:
            return Alert(title: Text("Trash button pressed"), message: Text("Company Id: \(message)"))
        case .moreDetails:
            return Alert(title: Text("MoreDetails button pressed"), message: Text("Company Id: \(message)"))
        case .none:
            return Alert(title: Text("Error"))
        }
    }
    
    func responseAlert() -> Alert {
        switch responseError {
        case .badRequest:
            return Alert(title: Text("Bad request"))
        case .unauthorised:
            return Alert(title: Text("Ошибка авторизации"))
        case .fatalError:
            return Alert(title: Text("Все упало"))
        case .none:
            return Alert(title: Text("Error"))
        }
    }
    
    func fetchData() {
        RequestsFactory.shared.createRequest(for: .getAllCompanies) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self?.cards.append(contentsOf: cards)
                case .failure(let error):
                    self?.isLoading = false
                    if let error = error as? ResponseError {
                        if error == .badRequest {
//                            self?.showAlert.toggle()
//                            self?.alertIdentifier = AlertIdentifier(id: .responseAlert)
//                            self?.responseError = .badRequest
                        } else if error == .unauthorised {
                            
                        } else if error == .fatalError {
                            
                        }
                    }
                    print("Failure case error: \(String(describing: error))")
                }
            }
        }
    }
}
