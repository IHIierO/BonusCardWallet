//
//  Endpoint.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation

/// Represents unique API endpoints
@frozen enum Endpoint: String, CaseIterable, Hashable {
    /// Endpoint get All Companies
    case getAllCompanies
    /// Endpoint to get All CompaniesI deal
    case getAllCompaniesIdeal
    /// Endpoint to get All Companies Long
    case getAllCompaniesLong
    /// Endpoint to get All Companies Error
    case getAllCompaniesError
}

