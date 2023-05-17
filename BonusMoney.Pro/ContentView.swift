//
//  ContentView.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        NavigationView {
            ProfilePage()
            //HelloView().environmentObject(globalVariables)
        }
    }
}

