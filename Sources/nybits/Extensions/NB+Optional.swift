//
//  NB+Optional.swift
//  nybits
//
//  Created by ny on 9/2/24.
//

import Foundation

// MARK: - Optional Extensions

/// Defines a custom postfix operator `~` for handling `Optional` values.

public extension Optional {
    
    /// Returns whether the optional value is `nil`.
    ///
    /// - Returns: `true` if the value is `nil`, otherwise `false`.
    var isNil: Bool {
        return self == nil
    }
}

// MARK: - Default Optional operator

postfix operator ~
infix operator ~~

public protocol Defaultable {
    static var defaultValue: Self { get }
}

extension Bool: Defaultable {
    public static var defaultValue: Bool { false }
}

public extension Optional where Wrapped: Defaultable {
    static postfix func ~ (value: Optional) -> Wrapped {
        return value ?? Wrapped.defaultValue
    }
    
    static func ~~ (lhs: Optional, rhs: Wrapped) -> Wrapped {
        return lhs ?? rhs
    }
    
    static func ~~ (lhs: Any?, rhs: Wrapped.Type) -> Wrapped {
        return lhs as? Wrapped ?? rhs.defaultValue
    }
    
    static func ~~ (lhs: Any?, rhs: Wrapped) -> Wrapped {
        return lhs as? Wrapped ?? rhs
    }
}
