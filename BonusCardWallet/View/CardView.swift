//
//  CardView.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 13.04.2023.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var viewModel: CardViewViewModel
    let card: CardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 4) {
                Text(card.mobileAppDashboard.companyName)
                    .font(.system(size: 24))
                    .foregroundColor(Color(hex: card.mobileAppDashboard.highlightTextColor))
                Spacer()
                //CardLogoImage(urlString: card.mobileAppDashboard.logo)
                AsyncImage(url: URL(string: card.mobileAppDashboard.logo), content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                })
                    .frame(width: 40, height: 40)
//                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
            }
            Divider()
            HStack(alignment: .bottom, spacing: 4) {
                RollingText(font: .system(size: 24), value: card.customerMarkParameters.loyaltyLevel.requiredSum)
                    .foregroundColor(Color(hex: card.mobileAppDashboard.highlightTextColor))
            Text("баллов")
                    .font(.system(size: 18))
                    .foregroundColor(Color(hex: card.mobileAppDashboard.textColor))
            }
            HStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Кешбек")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: card.mobileAppDashboard.textColor))
                    HStack(spacing: 2) {
                        RollingText(font: .system(size: 18), value: card.customerMarkParameters.loyaltyLevel.number)
                            .foregroundColor(Color(hex: "1a1a1a"))
                        Text("%")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: "1a1a1a"))
                    }
                }
                VStack(alignment: .leading) {
                    Text("Уровень")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: card.mobileAppDashboard.textColor))
                    Text(card.customerMarkParameters.loyaltyLevel.name)
                        .font(.system(size: 18))
                        .foregroundColor(Color(hex: "1a1a1a"))
                }
            }
            Divider()
            HStack(spacing: 50) {
                Button {
                    viewModel.alertItem = AlertItem(title: .init("Yue button pressed"), message: .init("Company Id: \(card.company.companyId)"))
                } label: {
                    Image("eye_white")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(hex: card.mobileAppDashboard.mainColor))
                }
                Button {
                    viewModel.alertItem = AlertItem(title: .init("Trash button pressed"), message: .init("Company Id: \(card.company.companyId)"))
                } label: {
                    Image("trash_white")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(hex: card.mobileAppDashboard.accentColor))
                }
                Button {
                    viewModel.alertItem = AlertItem(title: .init("MoreDetails button pressed"), message: .init("Company Id: \(card.company.companyId)"))
                } label: {
                    Text("Подробнее")
                        .font(.system(size: 18))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .foregroundColor(Color(hex: card.mobileAppDashboard.mainColor))
                }
                .buttonStyle(.bordered)
                .tint(Color(hex: card.mobileAppDashboard.backgroundColor))
                .cornerRadius(12)

            }
            .frame(maxWidth: .infinity)
        }
        .padding(15)
        .background {
            Color(hex: card.mobileAppDashboard.cardBackgroundColor)
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
