//
//  CardViewViewModel.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import Foundation
import SwiftUI

enum MyAlerts {
    case yey
    case trash
    case moreDetails
}

final class CardViewViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var alertType: MyAlerts? = nil
    
    func getAlert() -> Alert {
        switch alertType {
        case .yey:
            return Alert(title: Text("Yey button pressed"))
        case .trash:
            return Alert(title: Text("Trash button pressed"))
        case .moreDetails:
            return Alert(title: Text("MoreDetails button pressed"))
        case .none:
            return Alert(title: Text("Error"))
        }
    }
    
}
