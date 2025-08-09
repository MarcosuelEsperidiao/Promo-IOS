//
//  String+PhoneFormatter.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 02/08/25.
//

import Foundation

extension String {
    func formatPhoneNumber() -> String {
        let digits = self.filter { $0.isNumber }

        switch digits.count {
        case 0..<3:
            return "(\(digits)"
        case 3..<7:
            return "(\(digits.prefix(2))) \(digits.suffix(from: digits.index(digits.startIndex, offsetBy: 2)))"
        case 7..<11:
            return "(\(digits.prefix(2))) \(digits[digits.index(digits.startIndex, offsetBy: 2)]) \(digits[digits.index(digits.startIndex, offsetBy: 3)..<digits.index(digits.startIndex, offsetBy: 7)])-\(digits.suffix(from: digits.index(digits.startIndex, offsetBy: 7)))"
        default:
            let start = digits.prefix(2)
            let middle1 = digits[digits.index(digits.startIndex, offsetBy: 2)]
            let middle2 = digits[digits.index(digits.startIndex, offsetBy: 3)..<digits.index(digits.startIndex, offsetBy: 7)]
            let end = digits.suffix(from: digits.index(digits.startIndex, offsetBy: 7)).prefix(4)
            return "(\(start)) \(middle1) \(middle2)-\(end)"
        }
    }
}
