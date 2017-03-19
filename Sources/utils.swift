//
//  utils.swift
//  fabi
//
//  Created by Marcio Klepacz on 1/13/17.
//  Copyright © 2017 Marcio Klepacz. All rights reserved.
//

import Foundation

/// Shamessly copied from: https://github.com/matthewcheok/Kaleidoscope/blob/238c1942163e251d3f74bcae67531085f29ecda9/Kaleidoscope/Regex.swift

public extension String {
    public func match(regex: String, line: Bool = true) -> String? {
        if let range = self.range(of: "^\(regex)", options: .regularExpression, range: self.startIndex..<self.endIndex, locale: nil) {
            return self.substring(with: range)
        }
        
        return nil
    }
}

public func preprocess(_ input: String) -> String {
    var input = input
    // Step 1. Adding another slash to the line breaker, so regex can match, or it will ignores the line break token when trying to match.     
    input = input.replacingOccurrences(of: "\n", with: "\\n")
    
    // Step 2. Grabing all JS between `&` and `@@` and replacing line breaker with: `;;`
    let regex = "\\&\\\\n(.*?)\\@@"
    var results = [(String, Range<String.Index>)]()
    var startIn = input.startIndex
    while let range = input.range(of: regex, options: .regularExpression, range: startIn..<input.endIndex, locale: nil) {
        let js = input.substring(with: range)
        results.append((js, range))
        startIn = range.upperBound
    }

    let js = results.map { $0.0.replacingOccurrences(of: "\\n", with: ";;")}
    
    for i in 0..<results.count {
        input = input.replacingCharacters(in: results[i].1, with: js[i])
    }
    // Step 3. Replacing line breakers with space
    input = input.replacingOccurrences(of: "\\n", with: " ")
    
    return input
}


