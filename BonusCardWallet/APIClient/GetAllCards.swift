//
//  GetAllCards.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation

final class GetAllCardsService {
    static let shared = GetAllCardsService()
    
    var cards: [CardModel] = []
    
    func getAllCards() {
        print("Start")
        let parameters = "{\n\t\"offset\": 0\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://dev.bonusmoney.pro/mobileapp/getAllCompanies")!,timeoutInterval: Double.infinity)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          
            do {
               // print(String(data: data, encoding: .utf8)!)
                let result = try JSONDecoder().decode([CardModel].self, from: data)
                self.cards = result
                print("Result: \(self.cards)")
            }
            catch {
                print("Error: \(String(describing: error))")
            }
        }

        task.resume()
    }
}
