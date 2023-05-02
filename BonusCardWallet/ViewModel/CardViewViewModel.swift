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
    
    @Published var db: SQLiteDatabase?
    
    public let part1DbPath = directoryUrl?.appendingPathComponent("db.sqlite").relativePath
    
    func fetchData(offset: Int) {
        RequestsFactory.shared.createRequest(for: .getAllCompanies, offset: offset) { [weak self] result in
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
    
    func fetchCards_AsyncAwait() async {
            do {
                let getAllCardsService = GetAllCardsService_With_Feature_AsyncAwait.shared
                let result = try await getAllCardsService.getAllCards(endpoint: .getAllCompanies)
                cards.append(contentsOf: result)
            } catch let error{
                isLoading = false
                alertItem = AlertItem(title: .init("Error"), message: .init(error.localizedDescription))
                print("Failure case error: \(String(describing: error))")
            }
        }
    
    func openDB(with path: String) throws {
        do {
            db = try SQLiteDatabase.open(path: path)
            print("Successfully opened connection to database.")
        } catch SQLiteError.OpenDatabase(_) {
            print("Unable to open database.")
        }
    }
}
