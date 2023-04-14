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
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            print("Status code" + " " + String(describing: httpResponse.statusCode))
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.filedToGetData))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 400 {
                    let result = try? JSONDecoder().decode(ServerResponseMessageModel.self, from: data)
                    completion(.failure(ResponseError.badRequest))
                    print("bad Request")
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(ResponseError.unauthorised))
                    print("Ошибка авторизации")
                } else if httpResponse.statusCode == 500 {
                    completion(.failure(ResponseError.fatalError))
                    print("Все упало")
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode([CardModel].self, from: data)
                completion(.success(result))
            }
            catch {
                print(String(data: data, encoding: .utf8)!)
                completion(.failure(error))
                print("Catch error: \(String(describing: error))")
            }
        }

        task.resume()
    }
}
