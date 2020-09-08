//
//  StringExtensions.swift
//  EUtils
//
//  Created by LynnCheng on 2019/10/24.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation

public extension String {
    func stringToDate(dateFormat:String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }
    
    var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .filter{!$0.isEmpty}
    }
    
    func regexMatch(_ pattern:String) -> Bool {
        let matcher = Regex(pattern: pattern)
        if matcher.match(self) {
            return true
        } else {
            return false
        }
    }
    
    func isEmailAddr() -> Bool {
        return regexMatch("^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }
    
    func isPhoneNum() -> Bool {
        return regexMatch("^(1[2-9]|92|98)[0-9]{9}$")
    }
    
    func base64() -> String {
        if let plainData = self.data(using: String.Encoding.utf8) {
            let base64String = plainData.base64EncodedString(options:NSData.Base64EncodingOptions.init(rawValue: 0))
            return base64String
        } else {
            return ""
        }
    }
    
    func decodeWithBase64() -> String {
        if let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0)) {
            let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            return decodedString
        } else {
            return ""
        }
    }
}

