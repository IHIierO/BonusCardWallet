//
//  BonusMoney_ProApp.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

//@AppStorage("language")
//var globalLanguage = LocalizationService.shared.language

@main
struct BonusMoney_ProApp: App {
    
    @StateObject var globalVariables = GlobalVariables.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(globalVariables)
        }
    }
}
