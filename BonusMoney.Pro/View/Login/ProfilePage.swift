//
//  ProfilePage.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct ProfilePage: View {
    
    @State private var fieldsLogo = UserTextFieldLogo.allCases
    @State private var goToUserAgreement = false
    
    @State private var firstName = ""
    
    var body: some View {
        ZStack{
            Color.mainBackground
                .ignoresSafeArea()
            VStack{
                VStack(alignment: .leading) {
                    Text("Расскажите нам о себе")
                        .font(.system(size: 20).bold())
                        .foregroundColor(.mainText)
                        .padding(.vertical)
                    Text("Пожалуйста, заполните анкету актуальными данными, они могут Вам понадобиться для восстановления доступа к Вашей электронной карте.")
                        .foregroundColor(.secondText)
                }
                .padding(.horizontal)
                VStack {
                    
                    ForEach(fieldsLogo, id: \.rawValue) { field in
                        HStack(spacing: 15){
                            Image(field.rawValue)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.secondText)
                                .frame(width: 25, height: 25, alignment: .center)

                            TextField(field.textfieldPlaceholder, text: $firstName)
                        }
                        Divider()
                            .overlay {
                                Color.mainText
                            }
                            .frame(height: 2)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 30)
                Spacer()
                VStack(spacing: 0){
                    Text("Нажимая «Продолжить», Вы соглашаетесь с условиями")
                        .foregroundColor(.secondText)
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                        .padding(.horizontal)
                    NavigationLink(destination: Text("Пользовательское соглашение"), isActive: $goToUserAgreement) {
                        VStack(spacing: 0) {
                            Text("Пользовательского соглашения")
                                .foregroundColor(.secondText)
                            Divider()
                        }
                        .padding(.horizontal, 50)
                        
                    }
                    .padding()
                }
                Button {
                    print("Button pressed")
                } label: {
                    Text("Продолжить")
                        .foregroundColor(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 40, alignment: .center)
                        }
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
