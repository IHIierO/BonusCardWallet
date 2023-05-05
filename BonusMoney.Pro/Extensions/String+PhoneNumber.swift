//
//  String+PhoneNumber.swift
//  BonusMoney.Pro
//
//  Created by Artem Vorobev on 04.05.2023.
//

import Foundation

extension String {
    func formatPhoneNumber() -> String {
        // Remove any character that is not a number
        let numbersOnly = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.count
    
        // Check for supported phone number length
        if length > 11 {
            return String(numbersOnly.prefix(11)).formatPhoneNumber()
        } else if length < 10 {
            return numbersOnly
        }
    
        var sourceIndex = 0
    
        // Leading Number
        var leadingNumber = ""
        if length == 11, numbersOnly.first == "8" {
            leadingNumber = "+7" + " "
            sourceIndex += 1
        } else if length == 11, let leadChar = numbersOnly.first, numbersOnly.first == "7"{
            leadingNumber = "+" + String(leadChar) + " "
            sourceIndex += 1
        }
    
        // Area code
        var areaCode = ""
        let areaCodeLength = 3
        guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
            return numbersOnly
        }
        areaCode = String(format: "(%@) ", areaCodeSubstring)
        sourceIndex += areaCodeLength
    
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return numbersOnly
        }
        sourceIndex += prefixLength
    
        // First Suffix, 2 characters
        let firstSuffixLength = 2
        guard let firstSuffix = numbersOnly.substring(start: sourceIndex, offsetBy: firstSuffixLength) else {
            return numbersOnly
        }
        
        // Second Suffix, 2 characters
        let secondSuffixLength = 2
        guard let secondSuffix = numbersOnly.substring(start: sourceIndex + firstSuffixLength, offsetBy: firstSuffixLength) else {
            return numbersOnly
        }
    
        return leadingNumber + areaCode + prefix + "-" + firstSuffix + "-" + secondSuffix
    }
}

extension String {
    func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
    
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
    
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
