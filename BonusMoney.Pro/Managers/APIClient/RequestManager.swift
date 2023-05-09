//
//  RequestPhoneVerification.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import SwiftUI

final class RequestManager {
    
    static let shared = RequestManager()
    
    func requestPhoneVerification(for phoneNumber: String, verificationType: GlobalVariables.RequestVerificationType = .null, completion: @escaping (Result<PhoneVerificationModel, NetworkError>) -> Void) {
        let parameters = "{\r\n    \"countryCode\": \"RU\",\r\n    \"phone\": \"\(phoneNumber)\",\r\n    \"type\": \(verificationType.rawValue)\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://bm-app.com/mobileapp/register/sendPhoneVerification")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
              completion(.failure(NetworkError.notFound))
            print(String(describing: error))
            return
          }
            do {
                print(String(data: data, encoding: .utf8)!)
                let result = try JSONDecoder().decode(PhoneVerificationModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.underlyingError(error)))
            }
        }

        task.resume()
    }
    
    func verifyCallToPhone(from outgoingNumber: String, to incomingNumber: String, completion: @escaping (Result<VerifyModel, NetworkError>) -> Void) {
        let parameters = "{\r\n    \"phone\": \"\(outgoingNumber)\",\r\n    \"to\": \"\(incomingNumber)\"\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://bm-app.com/mobileapp/register/verifyPhoneVerificationCall")!,timeoutInterval: Double.infinity)
        request.addValue("89818124727", forHTTPHeaderField: "TOKEN")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

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
                    let result = try JSONDecoder().decode(VerifyModel.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(NetworkError.underlyingError(error)))
                    print("Catch error: \(String(describing: error))")
                }
            }
          //print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    
}
