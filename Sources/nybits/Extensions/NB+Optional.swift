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

/// Postfix operator `~` used for unwrapping optionals
postfix operator ~

/// Infix operator `???` used for providing default values or unwrapping optionals
infix operator ???

/// Protocol `Defaultable` that provides a static `defaultValue` property
public protocol Defaultable {
    static var defaultValue: Self { get }
}

/// Extension for `Optional` to define utility methods and operators
public extension Optional {
    /// Postfix operator implementation for unwrapping `Optional` values.
    /// If the value is `nil`, it triggers a precondition failure.
    /// - Parameter value: An optional value to be unwrapped.
    /// - Returns: The unwrapped value.
    static postfix func ~ (value: Optional) -> Wrapped {
        guard let value else { preconditionFailure("\\(String(describing: value)) does not implement Defaultable") }
        return value
    }

    /// Executes a closure if the `Optional` has a value.
    /// - Parameter closure: The closure to execute if the value is not `nil`.
    func then(_ closure: (Wrapped) -> Void) {
        if let value = self { closure(value) }
    }
}

/// Extension to make `Optional` conform to `Defaultable` where the `Wrapped` type conforms to `Defaultable`.
extension Optional: Defaultable where Wrapped: Defaultable {
    /// Provides a default value of `nil` for `Optional` types.
    public static var defaultValue: Wrapped? { nil }
}

/// Extension for `Optional` where the wrapped type is a collection, providing a property to check if it's empty.
public extension Optional where Wrapped: Collection {
    /// Checks whether the optional collection is empty.
    /// - Returns: `true` if the collection is empty or `nil`; otherwise, `false`.
    var isEmpty: Bool {
        return self?.isEmpty ?? false
    }
}

/// Extension for `Optional` where the wrapped type conforms to `Defaultable`.
public extension Optional where Wrapped: Defaultable {
    /// Postfix operator for unwrapping or returning a default value if `nil`.
    /// - Parameter value: An optional value.
    /// - Returns: The unwrapped value or the type's default value if `nil`.
    static postfix func ~ (value: Optional) -> Wrapped {
        return value ?? Wrapped.defaultValue
    }
    
    /// Infix operator that returns the optional value or a provided fallback.
    /// - Parameters:
    ///   - lhs: The Optional value.
    ///   - rhs: A fallback value to return if `lhs` is `nil`.
    /// - Returns: The unwrapped value or the fallback.
    static func ??? (lhs: Optional, rhs: Wrapped) -> Wrapped {
        return lhs ?? rhs
    }

    /// Infix operator for casting `Any?` to the desired type or providing a default.
    /// - Parameters:
    ///   - lhs: Any optional value.
    ///   - rhs: The type to cast to.
    /// - Returns: The casted value or the type's default value.
    static func ??? (lhs: Any?, rhs: Wrapped.Type) -> Wrapped {
        return lhs as? Wrapped ?? rhs.defaultValue
    }
    
    /// Infix operator for casting `Any?` to the desired type or providing a fallback value.
    /// - Parameters:
    ///   - lhs: Any optional value.
    ///   - rhs: The fallback value to return if `lhs` is `nil`.
    /// - Returns: The casted value or the fallback.
    static func ??? (lhs: Any?, rhs: Wrapped) -> Wrapped {
        return lhs as? Wrapped ?? rhs
    }
}

// MARK: - ny's Defaultable Foundation Extensions

#if !DISABLE_FOUNDATION_DEFAULTABLE

extension Bool: Defaultable {
    /// Provides a default value of 'false' for `Bool`
    public static var defaultValue: Bool { false }
}

extension Float: Defaultable {
    /// Provides a default value of `0.0` for `Float`
    public static var defaultValue: Float { 0.0 }
}

extension Double: Defaultable {
    /// Provides a default value of `0.0` for `Double`
    public static var defaultValue: Double { 0.0 }
}

extension CGFloat: Defaultable {
    /// Provides a default value of `0.0` for `CGFloat`
    public static var defaultValue: CGFloat { 0.0 }
}

extension Character: Defaultable {
    /// Provides a default value of a space character `" "` for `Character`
    public static var defaultValue: Character { " " }
}

extension Array: Defaultable {
    /// Provides an empty `Array` as the default value for `Array`
    public static var defaultValue: Array<Element> { [] }
}

extension Dictionary: Defaultable {
    /// Provides an empty `Dictionary` as the default value for `Dictionary`
    public static var defaultValue: Dictionary<Key, Value> { [:] }
}

extension Set: Defaultable {
    /// Provides an empty `Set` as the default value for `Set`
    public static var defaultValue: Set<Element> { [] }
}

extension UUID: Defaultable {
    /// Provides a new `UUID` as the default value for `UUID`
    public static var defaultValue: UUID { UUID() }
}

#endif
