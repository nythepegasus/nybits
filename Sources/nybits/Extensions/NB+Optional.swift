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

public extension Optional {
    static postfix func ~ (value: Optional) -> Wrapped {
        guard let value else { preconditionFailure("\(String(describing: value)) does not implement Defaultable") }
        return value
    }
    
    func then(_ closure: (Wrapped) -> Void) {
        if let value = self { closure(value) }
    }
}

extension Optional: Defaultable where Wrapped: Defaultable {
    public static var defaultValue: Wrapped? { nil }
}

public extension Optional where Wrapped: Collection {
    var isEmpty: Bool {
        return self?.isEmpty ?? false
    }
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

// MARK: - ny's Defaultable Foundation Extensions

#if !DISABLE_FOUNDATION_DEFAULTABLE

extension Bool: Defaultable {
    public static var defaultValue: Self { false }
}

extension Float: Defaultable {
    public static var defaultValue: Self { 0.0 }
}

extension Double: Defaultable {
    public static var defaultValue: Self { 0.0 }
}

extension CGFloat: Defaultable {
    public static var defaultValue: Self { 0.0 }
}

extension Character: Defaultable {
    public static var defaultValue: Self { " " }
}

extension Array: Defaultable {
    public static var defaultValue: Self { [] }
}

extension Dictionary: Defaultable {
    public static var defaultValue: Self { [:] }
}

extension Set: Defaultable {
    public static var defaultValue: Self { [] }
}

extension UUID: Defaultable {
    public static var defaultValue: Self { UUID() }
}

#endif
