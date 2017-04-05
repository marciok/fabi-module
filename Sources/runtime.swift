//
//  runtime.swift
//  fabi
//
//  Created by Marcio Klepacz on 2/27/17.
//  Copyright © 2017 Marcio Klepacz. All rights reserved.
//

import Foundation
import v8Wrap
// import JavaScriptCore

enum JSRuntimeError: Error {
    case objectsDontExist(String)
    case undefined
}

struct JSRuntime {
    // private let context = JSContext()!
    
    init() {
        self.registerHelpers()
    }
    
    private mutating func registerHelpers() {
        // self["bubulu"] = Bubulu.self
    }
    
    // public subscript(key: String) -> Any? {
    //     set {
    //         // self.context.setObject(newValue, forKeyedSubscript: key as (NSCopying & NSObjectProtocol)!)
    //     }
    //     get {
    //         // return self.context.objectForKeyedSubscript(key)
    //     }
    // }
    
    func evaluate(_ body: String, params: [String: String]) throws -> Content {
      /*
      let params = [":x" : "Shalom", ":y" : " World"]
let paramsDeclaration = params.keys.map{ String($0.characters.dropFirst()) }.joined(separator: ",")
let body = "return x + y"
let paramsValue = Array(params.values)
let jsSource = "(function(\(paramsDeclaration)) { \(body) })" //TODO: Remember there's a v8 function that wraps that call 
print(jsSource)
print(paramsValue)

test(jsSource, paramsValue)
      */
        let paramsDeclaration = params.keys.map{ String($0.characters.dropFirst()) }.joined(separator: ",")
        let paramsValue = Array(params.values)
        
        let jsSource = "(function(\(paramsDeclaration)) { \(body) })" //TODO: Remember there's a v8 function that wraps that call 

        test(jsSource, paramsValue)
        
        // _ = context.evaluateScript(jsSource)
        
        // guard let mainFunc = self["mainFunc"] as? JSValue,
        //     let result = mainFunc.call(withArguments: Array(params.values)) else  {
        //         throw JSRuntimeError.objectsDontExist("mainFunc and result is nil")
        // }
        //
        // guard !result.isUndefined else {
        //     throw JSRuntimeError.undefined
        // }
        //
        // return try JSRuntime.parse(result)
        return Content.html("Shalom")
    }
    
    
    // private static func parse(_ result: JSValue) throws -> Content {
    //     
    //     if result.isObject {
    //         let json = result.toObject()! as! [String: Any]
    //         let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    //         
    //         return Content.json(jsonData)
    //         
    //     }
    //     
    //     return Content.html(String(describing: result))
    // }
}

