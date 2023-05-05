//
//  CustomAlert.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI

struct CustomAlert<Content: View>: View {
    let content: Content
    let closeAction: () -> Void
    
    init(@ViewBuilder content: () -> Content, closeAction: @escaping () -> Void) {
        self.content = content()
        self.closeAction = closeAction
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    content
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
                
                Spacer()
                
                Button(action: closeAction) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 45))
                        .foregroundColor(.white)
                        
                        
                }
                .padding(.bottom, 20)
            }
        }
    }
}


