//
//  ButtonStyle.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation
import SwiftUI

struct CustomButton: ButtonStyle {
    let color: Color
    let radius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        
            configuration.label
            .padding(.vertical, Constants.small_double_margin)
            .background {
                RoundedRectangle(cornerRadius: radius)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        color.cornerRadius(radius)
                    }
            }
            .frame(maxWidth: .infinity)
       
    }
}

struct FilledButton: View {
    let title: String
    let action: () -> Void
    let color: Color
    let radius: CGFloat

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: Constants.middle_text_size))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(CustomButton(color: color, radius: radius))
    }
}
