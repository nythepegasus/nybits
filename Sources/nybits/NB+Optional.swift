//
//  NB+Optional.swift
//  nybits
//
//  Created by ny on 9/2/24.
//

import Foundation

postfix operator ~

public extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    static postfix func ~ (value: Optional) -> Wrapped {
        return value ?? customDefaultValue()
    }
    
    private static func customDefaultValue() -> Wrapped {
        switch Wrapped.self {
        case is String.Type:
            "" as! Wrapped
        case is Int.Type:
            -1 as! Wrapped
        case is Bool.Type:
            false as! Wrapped
        default:
            fatalError("No default for \(Wrapped.self).")
        }
    }
}
