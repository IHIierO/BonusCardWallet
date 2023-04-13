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
                .trim(from: 0, to: 0.4)
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .frame(width: 80, height: 80)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .padding()
            Text(placeHolder)
                .font(.system(size: 24))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        }
    }
}

