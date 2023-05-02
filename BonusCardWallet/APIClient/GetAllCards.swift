//
//  GetAllCards.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation

final class GetAllCardsService {
    static let shared = GetAllCardsService()
    
    var offsetX = 0
    let limitX = 5
    
    func getAllCards(endpoint: Endpoint, offset: Int, completion: @escaping (Result<[CardModel], NetworkError>) -> Void) {
        
        
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
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.notFound))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 400 {
                    guard let result = try? JSONDecoder().decode(ServerResponseMessageModel.self, from: data) else {
                        completion(.failure(NetworkError.serverError(message: "Status code: \(httpResponse.statusCode)")))
                        return
                    }
                    completion(.failure(NetworkError.serverError(message: result.message)))
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(NetworkError.serverError(message: "Ошибка авторизации")))
                } else if httpResponse.statusCode == 500 {
                    completion(.failure(NetworkError.serverError(message: "Все упало")))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode([CardModel].self, from: data)
                completion(.success(result))
                self.offsetX += self.limitX
            }
            catch {
                completion(.failure(NetworkError.underlyingError(error)))
                print("Catch error: \(String(describing: error))")
            }
        }

        task.resume()
    }
}

final class GetAllCardsService_With_Feature {
    static let shared = GetAllCardsService_With_Feature()
    
    var offsetX = 0
    let limitX = 5
    
    func getAllCards(endpoint: Endpoint, offset: Int, completion: @escaping (Result<[CardModel], NetworkError>) -> Void) {
        
        let parameters = ["offset": offsetX]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            print("Error: cannot create JSON data")
            return
        }

        guard let url = URL(string: "http://dev.bonusmoney.pro/mobileapp/\(endpoint)") else {
                    return
                }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    let decodingError = error
                    let networkError = HTTPResponseHandler.handleResponse(data: data, response: response, decodingError: decodingError)
                    
                    if let error = networkError {
                        completion(.failure(error))
                    } else {
                        guard let data = data else {
                            completion(.failure(.notFound))
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode([CardModel].self, from: data)
                            completion(.success(result))
                            self.offsetX += self.limitX
                        }
                        catch {
                            completion(.failure(NetworkError.underlyingError(error)))
                            print("Catch error: \(String(describing: error))")
                        }
                    }
                }

        task.resume()
    }
}



final class GetAllCardsService_With_Feature_AsyncAwait {
    static let shared = GetAllCardsService_With_Feature_AsyncAwait()
    
    var offsetX = 0
    let limitX = 5
    
    func getAllCards(endpoint: Endpoint) async throws -> [CardModel] {
        let parameters = ["offset": offsetX]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            print("Error: cannot create JSON data")
            throw NetworkError.notFound
        }

        guard let url = URL(string: "http://dev.bonusmoney.pro/mobileapp/\(endpoint)") else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let networkError = HTTPResponseHandler.handleResponse(data: data, response: response, decodingError: nil)
            
            if let error = networkError {
                throw error
            } else {
                let result = try JSONDecoder().decode([CardModel].self, from: data)
                self.offsetX += self.limitX
                return result
            }
        } catch {
            throw NetworkError.underlyingError(error)
        }
    }
}

