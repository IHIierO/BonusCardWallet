//
//  Test_DB_Contact_Model.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 25.04.2023.
//

import Foundation


struct Contact {
  let id: Int32
  let name: NSString
}


extension Contact: SQLTable {
   /// Этот код определяет createStatement и добавляет инструкцию CREATE TABLE к контакту, которая полезна для группировки кода.
  static var createStatement: String {
    return """
    CREATE TABLE IF NOT EXISTS Contact(
      Id INT PRIMARY KEY NOT NULL,
      Name CHAR(255)
    );
    """
  }
}
