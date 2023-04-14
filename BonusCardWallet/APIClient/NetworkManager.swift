//
//  NetworkManager.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import UIKit
import SwiftUI

enum ServiceError: Error {
    case filedToCreateRequest
    case filedToGetData
}

enum ResponseError: Error {
    case badRequest
    case unauthorised
    case fatalError
}

class RequestsFactory {
    static let shared = RequestsFactory()
    
    public func createRequest(for request: Endpoint, completion: @escaping (Result<[CardModel], Error>) -> Void) {
        switch request {
        case .getAllCompanies:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompanies, completion: completion)
        case .getAllCompaniesIdeal:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompaniesIdeal, completion: completion)
        case .getAllCompaniesLong:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompaniesLong, completion: completion)
        case .getAllCompaniesError:
            GetAllCardsService.shared.getAllCards(endpoint: .getAllCompaniesError, completion: completion)
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
