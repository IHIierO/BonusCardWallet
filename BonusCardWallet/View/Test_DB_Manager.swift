//
//  Test_DB_Manager.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 25.04.2023.
//

import SwiftUI

struct Test_DB_Manager: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @State var name: String = ""
    @State var id: String = ""
    @State var isPresenting = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: CardViewViewModel
    var body: some View {
            VStack {
                SettingsView()
                    .frame(width: 300, height: 100)
                
                HStack {
                    Button(action: {
                        guard let path = viewModel.part1DbPath else {return}
                        print("File in path already exist: \(FileManager.default.fileExists(atPath: path))")
                       SQLiteDatabase.destroyDatabase(path: path)
                        
                    }, label: {
                        Text("Destroy database")
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                .padding(.bottom, 10)
                    Button(action: {
                        Task {
                            guard let path = viewModel.part1DbPath else {return}
                            do {
                                try viewModel.openDB(with: path)
                            } catch {
                                print("Can't open database")
                            }
                        }
                        
                    }, label: {
                        Text("Open database")
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    
                    Button(action: {
                        Task {
                            guard let db = viewModel.db else {
                                print("Database not found")
                                return
                            }
                            
                            do {
                                try db.createTable(table: Contact.self)
                                
                            } catch {
                                print(db.errorMessage)
                            }
                        }
                        
                    }, label: {
                        Text("Create table")
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }
                
                TextField("Enter name", text: $name)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                TextField("Enter id", text: $id)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                    .keyboardType(.decimalPad)
                Button(action: {
                    Task {
                        
                        guard let db = viewModel.db else {
                            print("Database not found")
                            return
                        }
                        
                        do {
                            guard let id = Int32(self.id) else {
                                print("can't convert string to Int32")
                                return
                            }
                            try db.insertContact(contact: Contact(id: id, name: self.name as NSString))
                        } catch {
                            print(db.errorMessage)
                        }
                        
                    }
                    
                    // go back to home page
                    //self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Add User".localized(language))
                })
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                HStack {
                    Button(action: {
                        Task {
                            guard let id = Int32(self.id) else {
                                print("can't convert string to Int32")
                                return
                            }
                            guard let db = viewModel.db else {
                                print("Database not found")
                                return
                            }
                            if let first = db.contact(id: id) {
                                      print("\(first.id) \(first.name)")
                                    }
                        }
                        
                        // go back to home page
                        //self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("Fetch User".localized(language))
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                .padding(.bottom, 10)
                    
                    Button(action: {
                        Task {
                            guard let db = viewModel.db else {
                                print("Database not found")
                                return
                            }
                            db.allContact()
                        }
                        
                        // go back to home page
                        //self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("Fetch all User".localized(language))
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }
                HStack {
                    Button(action: {
                        Task {
                            guard let db = viewModel.db else {
                                print("Database not found")
                                return
                            }
                            do {
                                guard let id = Int32(self.id) else {
                                    print("can't convert string to Int32")
                                    return
                                }
                                
                                try db.updateContact(for: id, contact: Contact(id: id, name: self.name as NSString))
                            } catch {
                                print(db.errorMessage)
                            }
                            
                        }
                        
                        // go back to home page
                        //self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("Update User".localized(language))
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                .padding(.bottom, 10)
                    
                    Button(action: {
                        Task {
                            guard let db = viewModel.db else {
                                print("Database not found")
                                return
                            }
                            do {
                                guard let id = Int32(self.id) else {
                                    print("can't convert string to Int32")
                                    return
                                }
                                
                                try db.deleteContact(for: id)
                            } catch {
                                print(db.errorMessage)
                            }
                            
                        }
                        
                        // go back to home page
                        //self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("Delete User".localized(language))
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }
            }
            .padding()
    }
}

struct Test_DB_Manager_Previews: PreviewProvider {
    static var previews: some View {
        Test_DB_Manager()
    }
}
