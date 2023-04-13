//
//  CardView.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct CardView: View {
    @StateObject private var viewModel = CardViewViewModel()
    @State var pointsValue: Int = 200
    @State var cashbackPercentageValue: Int = 1
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 4) {
                Text("Bonus Money")
                    .font(.system(size: 24))
                Spacer()
                Image(systemName: "creditcard")
                    .font(.system(size: 24))
            }
            Divider()
            HStack(alignment: .bottom, spacing: 4) {
                RollingText(font: .system(size: 24), value: $pointsValue)
                    .foregroundColor(Color(hex: "1a1a1a"))
            Text("баллов")
                    .font(.system(size: 18))
                    .foregroundColor(Color(hex: "949494"))
            }
            HStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Кешбек")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "949494"))
                    HStack(spacing: 2) {
                        RollingText(font: .system(size: 18), value: $cashbackPercentageValue)
                            .foregroundColor(Color(hex: "1a1a1a"))
                        Text("%")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: "1a1a1a"))
                    }
                }
                VStack(alignment: .leading) {
                    Text("Уровень")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "949494"))
                    Text("Базовый уровень тест")
                        .font(.system(size: 18))
                        .foregroundColor(Color(hex: "1a1a1a"))
                }
            }
            Divider()
            HStack(spacing: 50) {
                Button {
                    viewModel.alertType = .yey
                    viewModel.showAlert.toggle()
                } label: {
                    Image("eye_white")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(hex: "2688eb"))
                }
                Button {
                    viewModel.alertType = .trash
                    viewModel.showAlert.toggle()
                } label: {
                    Image("trash_white")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(hex: "ff3044"))
                }
                Button {
                    viewModel.alertType = .moreDetails
                    viewModel.showAlert.toggle()
                } label: {
                    Text("Подробнее")
                        .font(.system(size: 18))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.bordered)
                .cornerRadius(12)

            }
            .frame(maxWidth: .infinity)
            .alert(isPresented: $viewModel.showAlert) {
                viewModel.getAlert()
            }
        }
        .padding(15)
        .background {
            Color(hex: "ffffff")
                .ignoresSafeArea()
        }
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
