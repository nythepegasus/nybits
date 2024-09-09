//
//  NB+Optional.swift
//  nybits
//
//  Created by ny on 9/2/24.
//

import Foundation

// MARK: - Optional Extensions

/// Defines a custom postfix operator `~` for handling `Optional` values.
postfix operator ~


public extension Optional {
    
    /// Returns whether the optional value is `nil`.
    ///
    /// - Returns: `true` if the value is `nil`, otherwise `false`.
    var isNil: Bool {
        return self == nil
    }
    
    /// A custom postfix operator `~` that provides a default value for an `Optional` when it is `nil`.
    ///
    /// This operator will unwrap the optional if it contains a value, or it will return a default value if the optional is `nil`. The default value depends on the type of the wrapped value:
    ///
    /// ```swift
    /// let d = Data(...)
    /// let s = String(data: d, encoding: .utf8)
    ///
    /// print(s~) // "" on nil/error
    /// ...
    /// let i: Int?
    ///
    /// print(i~) // -1
    /// ...
    /// let b: Bool?
    ///
    /// print(b~) // false
    /// ```
    ///
    /// - `String`: Defaults to an empty string (`""`).
    /// - `Int`: Defaults to `-1`.
    /// - `Bool`: Defaults to `false`.
    /// - Other types: Triggers a runtime `fatalError`.
    ///
    /// - Parameter value: The optional value to unwrap.
    /// - Returns: The unwrapped value or a default value based on the type of `Wrapped`.
    static postfix func ~ (value: Optional) -> Wrapped {
        return value ?? customDefaultValue()
    }
    
    /// Provides a default value based on the type of the `Optional`.
    ///
    /// This method is called by the custom postfix operator `~` when the optional is `nil`. It provides default values for specific types and triggers a fatal error for unsupported types.
    ///
    /// - Returns: A default value based on the type of `Wrapped`.
    private static func customDefaultValue() -> Wrapped {
        switch Wrapped.self {
        case is String.Type:
            return "" as! Wrapped
        case is Int.Type:
            return -1 as! Wrapped
        case is Bool.Type:
            return false as! Wrapped
        default:
            fatalError("No default value defined for type \(Wrapped.self).")
        }
    }
}
