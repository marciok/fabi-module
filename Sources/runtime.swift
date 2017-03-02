//
//  runtime.swift
//  fabi
//
//  Created by Marcio Klepacz on 2/27/17.
//  Copyright © 2017 Marcio Klepacz. All rights reserved.
//

import Foundation
import JavaScriptCore

enum JSRuntimeError: Error {
    case objectsDontExist(String)
    case undefined
}

struct JSRuntime {
    private let context = JSContext()!
    
    init() {
        self.registerHelpers()
    }
    
    private mutating func registerHelpers() {
        // self["bubulu"] = Bubulu.self
    }
    
    public subscript(key: String) -> Any? {
        set {
            self.context.setObject(newValue, forKeyedSubscript: key as (NSCopying & NSObjectProtocol)!)
        }
        get {
            return self.context.objectForKeyedSubscript(key)
        }
    }
    
    func evaluate(_ body: String, params: [String: String]) throws -> Content {
        let paramsDeclaration = params.keys.map{ String($0.characters.dropFirst()) }.joined(separator: ",")
        
        let jsSource = "var mainFunc = function(\(paramsDeclaration)) { \(body) }"
        
        _ = context.evaluateScript(jsSource)
        
        guard let mainFunc = self["mainFunc"] as? JSValue,
            let result = mainFunc.call(withArguments: Array(params.values)) else  {
                throw JSRuntimeError.objectsDontExist("mainFunc and result is nil")
        }
        
        guard !result.isUndefined else {
            throw JSRuntimeError.undefined
        }
        
        return try JSRuntime.parse(result)
    }
    
    
    private static func parse(_ result: JSValue) throws -> Content {
        
        if result.isObject {
            let json = result.toObject()! as! [String: Any]
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            return Content.json(jsonData)
            
        }
        
        return Content.html(String(describing: result))
    }
}

