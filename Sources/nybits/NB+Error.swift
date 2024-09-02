//
//  NB+Error.swift
//  nybits
//
//  Created by ny on 9/2/24.
//

import Foundation

infix operator |~>:LogicalDisjunctionPrecedence
infix operator <~|:LogicalDisjunctionPrecedence


public func logError(_ error: Error) {
    print("Error: \(error.localizedDescription)")
}

public extension Error? where Self == (any Error)? {
    @discardableResult
    static func <~| (lhs: @escaping (() -> Void), rhs: Error?) -> Error? {
        if !rhs.isNil { lhs() }
        return rhs
    }
    
    @discardableResult
    static func <~| (lhs: @escaping ((Error) -> Void), rhs: Error?) -> Error? {
        if !rhs.isNil { lhs(rhs!) }
        return rhs
    }

    static func |~> (lhs: Error?, rhs: @escaping (() -> Void)) {
        if lhs.isNil { rhs() }
    }
    
    static func |~> (lhs: Error?, rhs: @escaping ((Error) -> Void)) {
        if !lhs.isNil { rhs(lhs!) }
    }
}
