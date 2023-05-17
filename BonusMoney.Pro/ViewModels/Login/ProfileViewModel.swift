//
//  ProfileViewModel.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 12.05.2023.
//

import SwiftUI


//final class ProfileViewModel: ObservableObject {
//   @Published var first_name: String = ""
//   @Published var patronymic: String = ""
//   @Published var last_name: String = ""
//   @Published var gift: String = ""
//   @Published var gender: String = ""
//   @Published var phone: String = ""
//   @Published var mail: String = ""
//
//   var textFields: [Binding<String>] {
//       return [
//        Binding<String>(get: { self.first_name }, set: { self.first_name = $0 }),
//        Binding<String>(get: { self.patronymic }, set: { self.patronymic = $0 }),
//        Binding<String>(get: { self.last_name }, set: { self.last_name = $0 }),
//        Binding<String>(get: { self.gift }, set: { self.gift = $0 }),
//        Binding<String>(get: { self.gender }, set: { self.gender = $0 }),
//        Binding<String>(get: { self.phone }, set: { self.phone = $0 }),
//        Binding<String>(get: { self.mail }, set: { self.mail = $0 })
//       ]
//   }
//
//    func printProfileModel() {
//        print("ProfileModel: \(ProfileModel(id: UUID(), first_name: first_name, patronymic: patronymic, last_name: last_name, gift: gift, gender: gender, phone: phone, mail: mail))")
//    }
//}

enum Field {
    case textField(binding: Binding<String>)
    case picker(binding: Binding<String>)
    case datePicker
    case phoneTextField(binding: Binding<String>)
}

enum ProfilePicker {
    case gender
    case date
}

final class ProfileViewModel: ObservableObject {
    @Published var first_name: String = ""
    @Published var patronymic: String = ""
    @Published var last_name: String = ""
    @Published var gift: Date? = nil
    @Published var gender: String = ""
    @Published var phone: String = ""
    @Published var mail: String = ""
    @Published var profilePicker: ProfilePicker?
    
    let changedUserProfile = Notification.Name("changedUserProfile")
    

    var fields: [Field] {
            return [
                .textField(binding: Binding(get: { self.first_name }, set: { self.first_name = $0 })),
                .textField(binding: Binding(get: { self.patronymic }, set: { self.patronymic = $0 })),
                .textField(binding: Binding(get: { self.last_name }, set: { self.last_name = $0 })),
                .datePicker,
                .picker(binding: Binding(get: { self.gender }, set: { self.gender = $0 })),
                .phoneTextField(binding: Binding(get: { self.phone }, set: { self.phone = $0 })),
                .textField(binding: Binding(get: { self.mail }, set: { self.mail = $0 })),
            ]
        }
    
    func saveProfileModel(){
        print("Profile Model: \(ProfileModel(first_name: first_name, patronymic: patronymic, last_name: last_name, gift: formatDate().wrappedValue, gender: gender, phone: phone, mail: mail))")
        
        let profile = ProfileModel(first_name: first_name, patronymic: patronymic, last_name: last_name, gift: formatDate().wrappedValue, gender: gender, phone: phone, mail: mail.lowercased())
        
        let profileData = try? JSONEncoder().encode(profile)
        
        UserDefaults.standard.setValue(profileData, forKey: "profile")
        NotificationCenter.default.post(name: changedUserProfile, object: nil)
    }
    
    func formatDate() -> Binding<String> {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MMMM.yyyy"
            
        let dateString: String
               if let date = gift {
                   dateString = formatter.string(from: date)
               } else {
                   dateString = ""
               }
            
            return Binding<String>(
                get: { dateString },
                set: { newValue in
                    if let newDate = formatter.date(from: newValue) {
                        self.gift = newDate
                    }
                }
            )
        }
    
    func selectedDateBinding() -> Binding<Date> {
           Binding<Date>(
               get: { self.gift ?? Date() },
               set: { self.gift = $0 }
           )
       }
    
    func dateRange() -> ClosedRange<Date> {
            let calendar = Calendar.current
            let startDate = calendar.date(from: DateComponents(year: 1900, month: 1, day: 1))!
            let endDate = calendar.date(from: DateComponents(year: 2010, month: 12, day: 31))!
            return startDate...endDate
        }
}

