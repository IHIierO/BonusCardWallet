//
//  AppDelegate.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 30.04.2023.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "ffffff")
        
        
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#2688eb"),
            .font: UIFont.systemFont(ofSize: 24)
        ]
        
        appearance.titleTextAttributes = attrs
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        return true
    }
}
