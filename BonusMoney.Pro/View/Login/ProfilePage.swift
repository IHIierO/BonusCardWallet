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
    
    @StateObject var viewModel = ProfileViewModel()
    
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
                    
                    ForEach(viewModel.fields.indices, id: \.self) { index in
                            switch viewModel.fields[index] {
                            case .textField(let binding):
                                HStack {
                                    Image(fieldsLogo[index].rawValue)
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.secondText)
                                        .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                                    TextField(text: binding) {
                                        Text(fieldsLogo[index].textfieldPlaceholder)
                                            .font(.system(size: Constants.large_text_size))
                                    }
                                }
                                Divider()
                            case .picker(let binding):
                                HStack {
                                    Image(fieldsLogo[index].rawValue)
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.secondText)
                                        .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                                    TextField(text: binding) {
                                        Text(fieldsLogo[index].textfieldPlaceholder)
                                            .font(.system(size: Constants.large_text_size))
                                    }
                                        .disabled(true)
                                    
                                    Menu {
                                        Button("Male") {
                                            viewModel.gender = "Male"
                                        }
                                        Button("Female") {
                                            viewModel.gender = "Female"
                                        }
                                    } label: {
                                        Image("arrow_back")
                                            .resizable()
                                            .renderingMode(.template)
                                            .rotationEffect(.degrees(-90.0))
                                            .foregroundColor(.secondText)
                                            .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                                    }
                                }
                                Divider()
                            case .phoneTextField(let binding):
                                HStack {
                                    Image(fieldsLogo[index].rawValue)
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.secondText)
                                        .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                                    TextField(text: binding) {
                                        Text(fieldsLogo[index].textfieldPlaceholder)
                                            .font(.system(size: Constants.large_text_size))
                                    }
                                    .disabled(true)
                                    Image("confirmation_phone")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.secondText)
                                        .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                                }
                                Divider()
                            case .datePicker:
                                HStack {
                                    Image(fieldsLogo[index].rawValue)
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.secondText)
                                        .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                                    
                                    TextField(text: viewModel.formatDate()) {
                                        Text(fieldsLogo[index].textfieldPlaceholder)
                                            .font(.system(size: Constants.large_text_size))
                                    }
                                        .disabled(true)
                                    Button {
                                        viewModel.profilePicker = .date
                                    } label: {
                                        Image("arrow_back")
                                            .resizable()
                                            .renderingMode(.template)
                                            .rotationEffect(.degrees(-90.0))
                                            .foregroundColor(.secondText)
                                            .frame(width: Constants.small_icon_size, height: Constants.small_icon_size, alignment: .center)
                                    }
                                }
                                Divider()
                            }
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
                    .padding(.vertical, Constants.small_margin)
                }
                
                FilledButton(title: "Продолжить", action: {
                   viewModel.printProfileModel()
                }, color: Color.activeElement, radius: Constants.btn_radius)
                .padding(.horizontal, Constants.large_double_margin)
                .padding(.top)
            }
            .ignoresSafeArea(.keyboard)
            
            if viewModel.profilePicker == .date {
                CustomAlert {
                    VStack {
                        DatePicker("", selection: viewModel.selectedDateBinding(), in: viewModel.dateRange(), displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding([.top, .leading, .trailing])
                            .labelsHidden()
                            
                        FilledButton(title: "Done", action: {
                            viewModel.profilePicker = nil
                        }, color: .secondary, radius: Constants.btn_radius)
                        .padding(.vertical, Constants.small_margin)
                        .padding(.horizontal, Constants.large_margin)
                    }
                } closeAction: {
                    viewModel.profilePicker = nil
                }
            }
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
