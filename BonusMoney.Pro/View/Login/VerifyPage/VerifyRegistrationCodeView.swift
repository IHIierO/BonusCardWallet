//
//  ConfirmSMS.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 03.05.2023.
//

import SwiftUI

struct VerifyRegistrationCodeView: View {
    @State private var smsCode: [String] = ["","","",""]
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                        Text("Введите 4 цифры из sms-сообщения")
                            .font(.system(size: 18).bold())
                            .foregroundColor(Color(hex: Colors.mainText.rawValue))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                        
                        Text("Необходимо, чтобы подтвердить Вас")
                            .foregroundColor(Color(hex: Colors.secondText.rawValue))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding()
                
              
                
                HStack {
                    Spacer(minLength: 40)
                    ForEach((0..<smsCode.count), id: \.self) { field in
                        VStack{
                            TextField("", text: $smsCode[field])
                            Divider()
                                .overlay {
                                    Color(hex: Colors.mainText.rawValue)
                                        .frame(height: 2)
                                }
                        }
                        .padding()
                    }

                    Spacer(minLength: 40)
                }
                CountdownTimerView(seconds: 37, text: "Запросить SMS")
                    .foregroundColor(.secondText)
                    .padding(.vertical)
                CountdownTimerView(seconds: 37, text: "Запросить номер для звонка")
                    .foregroundColor(.secondText)
                    .padding(.bottom)
                Spacer()
                Button {
                    print("Button pressed")
                } label: {
                    Text("Продолжить")
                        .foregroundColor(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 40, alignment: .center)
                        }
                        .frame(width: 200, height: 40)
                }
            }
        }
    }
}

struct VerifyRegistrationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyRegistrationCodeView()
    }
}
