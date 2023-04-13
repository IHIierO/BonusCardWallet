//
//  GetAllCards.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation

final class GetAllCardsService {
    static let shared = GetAllCardsService()
    
    func getAllCards(endpoint: Endpoint, completion: @escaping (Result<[CardModel], Error>) -> Void) {
        print("Start")
        let parameters = "{\n\t\"offset\": 0\n}"
        let postData = parameters.data(using: .utf8)
        
        guard let url = URL(string: "http://dev.bonusmoney.pro/mobileapp/\(endpoint)") else {
            return
        }

        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
          guard let data = data, error == nil else {
              completion(.failure(error ?? ServiceError.filedToGetData))
            return
          }
          
            do {
                let result = try JSONDecoder().decode([CardModel].self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
                print("Error: \(String(describing: error))")
            }
        }

        task.resume()
    }
}
