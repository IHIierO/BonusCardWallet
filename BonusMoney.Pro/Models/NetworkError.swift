//
//  NetworkError.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation

enum NetworkError: LocalizedError, Identifiable {
    case notFound
    case badRequest
    case badURL
    case serverError(message: String)
    case underlyingError(Error)
    case unknown

    var id: String { localizedDescription }

    var errorDescription: String? {
        switch self {
        case .notFound: return "Not found"
        case .serverError(let message): return message
        case .underlyingError(let error): return error.localizedDescription
        case .unknown: return "Unknown error"
        case .badRequest: return "Bad Request"
        case .badURL: return "Bad URL"
        }
    }
}
