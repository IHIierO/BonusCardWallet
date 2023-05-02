//
//  TEST_loginPage.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 02.05.2023.
//

import SwiftUI
import Security

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isInvalidCredentialsAlertShown = false
    @State private var isLoggedIn = false
    @State private var showPassword = false
    
    var body: some View {
        //NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button("Sign In") {
                    if validateCredentials() && username == "Test@mail.ru" && password == "132Pac31" {
                            login()
                    } else {
                        isInvalidCredentialsAlertShown = true
                    }
                }
                .font(.title2)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
                .fullScreenCover(isPresented: $isLoggedIn, content: ContentView.init)
                
//                NavigationLink(destination: ContentView(), isActive: $isLoggedIn) {
//                                    EmptyView()
//                                }
            }
            .padding()
            .alert(isPresented: $isInvalidCredentialsAlertShown) {
                Alert(
                    title: Text("Invalid Credentials"),
                    message: Text("Please enter a valid username and password."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                loadCredentials()
        }
       // }
    }
    
    private func login() {
        // Perform login action
        saveCredentials()
        isLoggedIn = true
    }
    
    private func validateCredentials() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let passwordRegex = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"#
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return emailPredicate.evaluate(with: username.lowercased()) && passwordPredicate.evaluate(with: password)
    }
    
    private func saveCredentials() {
        let credentials = "\(username):\(password)"
        guard let data = credentials.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "loginCredentials",
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Error saving credentials to Keychain: \(status)")
        }
    }
    
    private func loadCredentials() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "loginCredentials",
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let existingItem = item as? [String: Any], let data = existingItem[kSecValueData as String] as? Data else {
            return
        }
        
        if let credentials = String(data: data, encoding: .utf8), let separatorIndex = credentials.firstIndex(of: ":") {
            username = String(credentials[..<separatorIndex])
            password = String(credentials[credentials.index(after: separatorIndex)...])
            if username == "Test@mail.ru" && password == "132Pac31" {
                login()
            }
        }
    }
}

