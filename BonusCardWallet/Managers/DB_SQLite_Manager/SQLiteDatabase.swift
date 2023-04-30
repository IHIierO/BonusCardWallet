//
//  SQLiteDatabase.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 25.04.2023.
//

import Foundation
import SQLite3

protocol SQLTable {
  static var createStatement: String { get }
}

let directoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

class SQLiteDatabase {
    private let dbPointer: OpaquePointer?
    private init(dbPointer: OpaquePointer?) {
        self.dbPointer = dbPointer
    }
    deinit {
        sqlite3_close(dbPointer)
    }
    
    
    
    // MARK: - Open SQLite Datebase
    static func open(path: String) throws -> SQLiteDatabase {
        var db: OpaquePointer?
        /// Здесь пытаемся открыть базу данных по указанному пути.
        if sqlite3_open(path, &db) == SQLITE_OK {
            /// В случае успеха создаем новый экземпляр SQLiteDatabase.
            return SQLiteDatabase(dbPointer: db)
        } else {
            /// В противном случае откладываем закрытие базы данных, если код состояния не является SQLITE_OK, и выдаем ошибку.
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            if let errorPointer = sqlite3_errmsg(db) {
                let message = String(cString: errorPointer)
                throw SQLiteError.OpenDatabase(message: message)
            } else {
                throw SQLiteError
                    .OpenDatabase(message: "No error message provided from sqlite.")
            }
        }
    }
    // MARK: - destroyDatabase
    static func destroyDatabase(path: String?) {
      guard let path = path else { return }
      do {
        if FileManager.default.fileExists(atPath: path) {
          try FileManager.default.removeItem(atPath: path)
            print("Database with path: \(path) will be destroyed")
        }
      } catch {
        print("Could not destroy \(path) Database file.")
      }
    }
    
    /// Здесь  добавляем вычисляемое свойство, которое просто возвращает самую последнюю ошибку, о которой знает SQLite. Если ошибки нет, он возвращает общее сообщение.
    public var errorMessage: String {
      if let errorPointer = sqlite3_errmsg(dbPointer) {
        let errorMessage = String(cString: errorPointer)
        return errorMessage
      } else {
        return "No error message provided from sqlite."
      }
    }
}
// MARK: - prepareStatement
extension SQLiteDatabase {
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        /// Здесь заявляем, что prepareStatement(_:) может выдавать ошибку, а затем используем guard для пробрасывания этой ошибки в случае сбоя sqlite3_prepare_v2(). Как и раньше, передаем сообщение об ошибке от SQLite соответствующему регистру нашего пользовательского перечисления.
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil)
                == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMessage)
        }
        return statement
    }
}
// MARK: - createTable
extension SQLiteDatabase {
    func createTable(table: SQLTable.Type) throws {
        let createTableStatement = try prepareStatement(sql: table.createStatement)
        defer {
            sqlite3_finalize(createTableStatement)
        }
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("\(table) table created.")
    }
}
// MARK: - insertContact
extension SQLiteDatabase {
  func insertContact(contact: Contact) throws {
    let insertSql = "INSERT INTO Contact (Id, Name) VALUES (?, ?);"
    let insertStatement = try prepareStatement(sql: insertSql)
    defer {
      sqlite3_finalize(insertStatement)
    }
    let name: NSString = contact.name
    guard
      sqlite3_bind_int(insertStatement, 1, contact.id) == SQLITE_OK  &&
      sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
        == SQLITE_OK
      else {
        throw SQLiteError.Bind(message: errorMessage)
    }
    guard sqlite3_step(insertStatement) == SQLITE_DONE else {
      throw SQLiteError.Step(message: errorMessage)
    }
    print("Successfully inserted row.")
  }
}
// MARK: - updateContact
extension SQLiteDatabase {
    func updateContact(for id: Int32, contact: Contact) throws {
    let updateSql = "UPDATE Contact SET Name = ? WHERE Id = ?;"
    let updateStatement = try prepareStatement(sql: updateSql)
    defer {
      sqlite3_finalize(updateStatement)
    }
    let name: NSString = contact.name
    guard
      sqlite3_bind_int(updateStatement, 2, id) == SQLITE_OK  &&
      sqlite3_bind_text(updateStatement, 1, name.utf8String, -1, nil)
        == SQLITE_OK
      else {
        throw SQLiteError.Bind(message: errorMessage)
    }
    guard sqlite3_step(updateStatement) == SQLITE_DONE else {
      throw SQLiteError.Step(message: errorMessage)
    }
    print("Successfully updated row.")
  }
}
// MARK: - deleteContact
extension SQLiteDatabase {
    func deleteContact(for id: Int32) throws {
    let deleteSql = "DELETE FROM Contact WHERE Id = ?;"
    let deleteStatement = try prepareStatement(sql: deleteSql)
    defer {
      sqlite3_finalize(deleteStatement)
    }
    guard
      sqlite3_bind_int(deleteStatement, 1, id) == SQLITE_OK
      else {
        throw SQLiteError.Bind(message: errorMessage)
    }
    guard sqlite3_step(deleteStatement) == SQLITE_DONE else {
      throw SQLiteError.Step(message: errorMessage)
    }
    print("Successfully deleted row.")
  }
}
// MARK: - Get contact
extension SQLiteDatabase {
  func contact(id: Int32) -> Contact? {
    let querySql = "SELECT * FROM Contact WHERE Id = ?;"
    guard let queryStatement = try? prepareStatement(sql: querySql) else {
      return nil
    }
    defer {
      sqlite3_finalize(queryStatement)
    }
    guard sqlite3_bind_int(queryStatement, 1, id) == SQLITE_OK else {
      return nil
    }
    guard sqlite3_step(queryStatement) == SQLITE_ROW else {
        print("Id not found")
      return nil
    }
    let id = sqlite3_column_int(queryStatement, 0)
    guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
      print("Query result is nil.")
      return nil
    }
    let name = String(cString: queryResultCol1) as NSString
    return Contact(id: id, name: name)
  }
}
// MARK: - Get all contact
extension SQLiteDatabase {
  func allContact() -> [Contact]? {
      var contacts: [Contact] = []
    let querySql = "SELECT * FROM Contact;"
    guard let queryStatement = try? prepareStatement(sql: querySql) else {
      return nil
    }
    defer {
      sqlite3_finalize(queryStatement)
    }
      while (sqlite3_step(queryStatement) == SQLITE_ROW) {
            let id = sqlite3_column_int(queryStatement, 0)
            let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
            let name = String(cString: queryResultCol1!)
            
          let contact: Contact = Contact(id: id, name: name as NSString)
          contacts.append(contact)
          }
      print("Query Result:")
      print("\(contacts)")
      return contacts
  }
}
