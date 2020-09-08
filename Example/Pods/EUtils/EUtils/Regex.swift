//
//  Regex.swift
//  EUtils
//
//  Created by LynnCheng on 2019/10/24.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import Foundation
public struct Regex {
    var regex: NSRegularExpression?
    
    public init(pattern: String) {
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
        }
    }
    
    public func match(_ input: String) -> Bool {
        regex?.matches(in: input, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, input.count))
        if let matches = regex?.matches(in: input, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, input.count)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}

