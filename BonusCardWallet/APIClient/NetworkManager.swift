//
//  NetworkManager.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import UIKit
import SwiftUI

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

class RequestsFactory {
    static let shared = RequestsFactory()
    
    public func createRequest(for request: Endpoint, offset: Int, completion: @escaping (Result<[CardModel], NetworkError>) -> Void) {
        switch request {
        case .getAllCompanies:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompanies, offset: offset, completion: completion)
        case .getAllCompaniesIdeal:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompaniesIdeal, offset: offset, completion: completion)
        case .getAllCompaniesLong:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompaniesLong, offset: offset, completion: completion)
        case .getAllCompaniesError:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompaniesError, offset: offset, completion: completion)
        }
    }
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private let cache = NSCache<AnyObject, AnyObject>()
    
    private override init() {}
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
            
            let cacheKey = NSString(string: urlString)
            
            if let image = cache.object(forKey: cacheKey) as? UIImage {
                completion(image)
                return
            }
            
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                self.cache.setObject(image, forKey: cacheKey)
                completion(image)
            }
            
            task.resume()
        }
}
