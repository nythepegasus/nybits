//
//  NB+Optional.swift
//  nybits
//
//  Created by ny on 9/2/24.
//

import Foundation

// MARK: - Default Optional operators/extensions

/// Postfix operator `~` used for unwrapping optionals
postfix operator ~

/// Infix operator `???` used for providing default values or unwrapping optionals
infix operator ???

/// Extension for `Optional` to define utility methods and operators
public extension Optional {
    /// Returns whether the optional value is `nil`.
    ///
    /// - Returns: `true` if the value is `nil`, otherwise `false`.
    var isNil: Bool {
        return self == nil
    }
    
    /// Executes a closure if the `Optional` has a value.
    /// - Parameter closure: The closure to execute if the value is not `nil`.
    func then(_ closure: (Wrapped) -> Void) {
        if let value = self { closure(value) }
    }
    
    #if ENABLE_UNSAFE_DEFAULTABLE_OPTIONAL
    /**
     Turns out that for better compile time errors with `Defaultable` these definitions cannot exist
     However, I personally have found them to be useful for debugging other things,
     so I'm keeping them behind this compiler flag.
     
     Please know that all of this is quite cursed, I wish Swift just had a preprocessor :(
     */
    /// Postfix operator implementation for unwrapping `Optional` values.
    /// If the value is `nil`, it triggers a precondition failure.
    /// - Parameter value: An optional value to be unwrapped.
    /// - Returns: The unwrapped value.
    static postfix func ~ (_ value: Optional) -> Wrapped {
        guard let value else { preconditionFailure("\(String(describing: Wrapped.self)) does not implement Defaultable") }
        return value
    }

    /// Infix operator that returns the optional value or a provided fallback.
    /// - Parameters:
    ///   - lhs: The Optional value.
    ///   - rhs: A fallback value to return if `lhs` is `nil`.
    /// - Returns: The unwrapped value or the fallback.
    static func ??? (_ lhs: Optional, _ rhs: Wrapped) -> Wrapped {
        return lhs ?? rhs
    }

    /// Infix operator for casting `Any?` to the desired type or providing a fallback value.
    /// - Parameters:
    ///   - lhs: Any optional value.
    ///   - rhs: The fallback value to return if `lhs` is `nil`.
    /// - Returns: The casted value or the fallback.
    static func ??? (_ lhs: Any?, _ rhs: Wrapped) -> Wrapped {
        return lhs as? Wrapped ?? rhs
    }
    
    /// Infix operator for casting `Any?` to the desired type or crash process with reason.
    /// - Parameters:
    ///   - lhs: Any optional value.
    ///   - rhs: The type to cast to.
    /// - Returns: The casted value or crashes.
    static func ??? (_ lhs: Any?, _ rhs: Wrapped.Type) -> Wrapped {
        guard let value = lhs as? Wrapped else { preconditionFailure("\(String(describing: lhs.self)) does not implement Defaultable") }
        return value
    }
    #endif
}

/// Protocol `Defaultable` that provides a static `defaultValue` property
public protocol Defaultable {
    static var defaultValue: Self { get }
}

/// Extension for `Optional` where the wrapped type is a collection, providing a property to check if it's empty.
public extension Optional where Wrapped: Collection {
    /// Checks whether the optional collection is empty.
    /// - Returns: `true` if the collection is empty or `nil`; otherwise, `false`.
    var isEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

/// Extension for `Optional` where the wrapped type conforms to `Defaultable`.
public extension Optional where Wrapped: Defaultable {
    /// Postfix operator for unwrapping or returning a default value if `nil`.
    /// - Parameter value: An optional value.
    /// - Returns: The unwrapped value or the type's default value if `nil`.
    static postfix func ~ (_ value: Optional) -> Wrapped {
        return value ?? Wrapped.defaultValue
    }
    
    /// Infix operator for casting `Any?` to the desired type or providing a default.
    /// - Parameters:
    ///   - lhs: Any optional value.
    ///   - rhs: The type to cast to.
    /// - Returns: The casted value or the type's default value.
    static func ??? (_ lhs: Any?, _ rhs: Wrapped.Type) -> Wrapped {
        return (lhs as? Wrapped)~
    }
}
