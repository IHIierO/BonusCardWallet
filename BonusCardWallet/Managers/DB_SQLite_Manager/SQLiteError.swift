//
//  SQLiteError.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 25.04.2023.
//

import Foundation

enum SQLiteError: Error {
  case OpenDatabase(message: String)
  case Prepare(message: String)
  case Step(message: String)
  case Bind(message: String)
}

