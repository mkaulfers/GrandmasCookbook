//
//  Constants.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/16/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import Foundation
import UIKit

struct Utilities
{
    //MARK: - Storyboard Strings
    struct Storyboard
    {
        //INFO: Set static so we can grab it without defining the structure object. 
        static let profileViewController = "profileViewController"
        static let loginViewController = "loginViewController"
        static let registerViewController = "registerViewController"
    }
    
    //MARK: - Validation Methods
    struct Validations
    {
        static func isEmailValid(_ email: String) -> Bool
        {
            let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            return emailTest.evaluate(with: email)
        }
        
        static func isPasswordValid(_ password: String) -> Bool
        {
            //INFO: Check password against Regular Expression. 8 Char min, Special Char, Number
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
    }
    
    //MARK: - Configuration Methods
    struct Configure
    {
        static func cleanString(_ stringToClean: String) -> String
        {
            let cleanedString = stringToClean.trimmingCharacters(in: .whitespacesAndNewlines)
            return cleanedString
        }
    }
}
