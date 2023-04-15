//
//  CardViewViewModel.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation
import SwiftUI

final class CardViewViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var isLoading = true
    
    @Published var alertItem: AlertItem?
    
    func fetchData() {
        RequestsFactory.shared.createRequest(for: .getAllCompanies) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self?.cards.append(contentsOf: cards)
                case .failure(let error):
                    self?.isLoading = false
                    self?.alertItem = AlertItem(title: .init("Error"), message: .init(error.localizedDescription))
                    print("Failure case error: \(String(describing: error))")
                }
            }
        }
    }
}
