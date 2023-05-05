//
//  HTTPResponseHandler.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation

class HTTPResponseHandler {
    static func handleResponse(data: Data?, response: URLResponse?, decodingError: Error?) -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .notFound
        }
        guard let data = data, decodingError == nil else {
            return .notFound
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 400 {
                guard let result = try? JSONDecoder().decode(VerifyCallToPhoneModelBadResponse.self, from: data) else {
                    return .serverError(message: "Status code: \(httpResponse.statusCode)")
                }
                return .serverError(message: result.message)
            } else if httpResponse.statusCode == 401 {
                return .serverError(message: "Ошибка авторизации")
            } else if httpResponse.statusCode == 500 {
                return .serverError(message: "Все упало")
            } else {
                return .serverError(message: "Status code: \(httpResponse.statusCode)")
            }
        }
        
        return nil
    }
}
