//
//  HUDProgressView.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct HUDProgressView: View {
    public var placeHolder: String
    @Binding var show: Bool
    @State var animate = false
    var body: some View {
        VStack(spacing: 28) {
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .butt, lineJoin: .round))
                .frame(width: 60, height: 60)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .padding()
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: animate)
                .onAppear { DispatchQueue.main.async { animate.toggle() } }
            Text(placeHolder)
                .font(.system(size: 24))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

