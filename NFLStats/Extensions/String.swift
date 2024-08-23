//
//  String.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 21/08/2024.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
        
    func isValidPassword() -> Bool {
    /*
            (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
            (?=.*[0-9].*[0-9])        Ensure string has two digits.
            (?=.*[a-z].*[a-z])        Ensure string has two lowercase letters.
            .{6}                      Ensure string is of length 6.
     */
        let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Z].*[A-Z])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z]).{6}$", options: .caseInsensitive)
        
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
    
}
