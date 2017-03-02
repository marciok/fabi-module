//
//  Bubulu.swift
//  fabi
//
//  Created by Marcio Klepacz on 2/26/17.
//  Copyright © 2017 Marcio Klepacz. All rights reserved.
//

import Foundation

enum RenderError: Error {
    case unableToParseFormat
}

class Bubulu {
    
    fileprivate class func renderHTML(tags: Any, indentLevel: Int = 0) throws -> String {
        var output = ""
        var tabs = ""
        
        for _ in 0..<indentLevel {
            tabs += "\t"
        }
        
        if let tags = tags as? Array<Any> {
            for tag in tags {
                output += (try renderHTML(tags: tag,  indentLevel: indentLevel)) + "\n"
            }
            
            return String(output.characters.dropLast())
        }
        guard let tags = tags as? [String: Any] else {
            throw RenderError.unableToParseFormat
        }
        
        for tag in tags {
            let noClosingTag = tag.key.characters.first! == "/"
            
            output += tabs
            output += "<\(noClosingTag ? String(tag.key.characters.dropFirst()) : tag.key)>"
            output += tag.value is String ? tag.value as! String : "\n" + (try renderHTML(tags: tag.value, indentLevel: indentLevel + 1)) + "\n" + tabs
            output += noClosingTag ? "" : "</\(tag.key.components(separatedBy: " ").first!)>"
            output += "\n"
        }
        
        return output
    }
}

// extension Bubulu: JSMethodsBridge {
//     
//     static func render(_ tags: Any) -> String? {
//         guard let html = try? renderHTML(tags: tags) else  {
//             return nil
//         }
//         
//         return html
//     }
// }
