//
//  TestProfileTextView.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 05.05.2023.
//

import SwiftUI

struct ProfileView: View {
    @State var profile: ProfileModel
    @State private var fieldsLogo = UserTextFieldLogo.allCases
    
    var body: some View {
        VStack {
            ForEach(Array(Mirror(reflecting: profile).children), id: \.label) { child in
                if let label = child.label {
                    HStack {
                        UserTextFieldLogo(rawValue: label)?.image
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.secondText)
                            .frame(width: 25, height: 25, alignment: .center)
                        
                        TextField(UserTextFieldLogo(rawValue: label)?.textfieldPlaceholder ?? "", text: Binding(
                            get: {
                                if let value = child.value as? CustomStringConvertible {
                                    return value.description
                                } else {
                                    return ""
                                }
                            },
                            set: { newValue in
                                switch label {
                                case "firstName":
                                    profile.first_name = newValue
                                case "patronymicName":
                                    profile.patronymic = newValue
                                case "lastName":
                                    profile.last_name = newValue
                                case "birthday":
                                    profile.gift = newValue
                                case "gender":
                                    profile.gender = newValue
                                case "phoneNumber":
                                    profile.phone = newValue
                                case "mail":
                                    profile.mail = newValue
                                default:
                                    break
                                }
                            }
                        ))
                    }
                }
            }
            Button("get user") {
                print("User: \(profile)")
            }
        }
    }
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        @State var profile: ProfileModel = ProfileModel(
               id: UUID(),
               first_name: "Artem",
               patronymic: "",
               last_name: "",
               gift: "",
               gender: "",
               phone: "",
               mail: ""
           )
        ProfileView(profile: profile)
    }
}
