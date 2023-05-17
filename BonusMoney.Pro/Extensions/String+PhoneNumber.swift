//
//  String+PhoneNumber.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation


extension String {
    func applyingMask(_ mask: String, replacementCharacter: Character) -> String {

        let allowedCharacterSet = CharacterSet.decimalDigits
        let cleanedPhoneNumber = self.components(separatedBy: allowedCharacterSet.inverted).joined()

        var formattedString = ""
        var cleanedIndex = cleanedPhoneNumber.startIndex

        for maskIndex in mask.indices {
            guard cleanedIndex < cleanedPhoneNumber.endIndex else { break }
            let maskCharacter = mask[maskIndex]

            if maskCharacter == replacementCharacter {
//                if cleanedIndex == cleanedPhoneNumber.startIndex && cleanedPhoneNumber.hasPrefix("8") {
//                    formattedString.append("7")
//                    cleanedIndex = cleanedPhoneNumber.index(after: cleanedIndex)
//                } else {
                    formattedString.append(cleanedPhoneNumber[cleanedIndex])
                    cleanedIndex = cleanedPhoneNumber.index(after: cleanedIndex)
//                }
            } else {
                formattedString.append(maskCharacter)
            }
        }
        return "+" + formattedString
    }
}


