//
//  NB+Error.swift
//  nybits
//
//  Created by ny on 9/2/24.
//

import Foundation

// MARK: - Custom Infix Operators

/// A custom infix operator for chaining success or error handling, using `NilCoalescingPrecedence`.
///
/// This operator is used to handle the case where a `nil` or non-`nil` `Error` can conditionally trigger a closure.
infix operator |~>: NilCoalescingPrecedence
/// Ensure left associativity to ensure predictable chaining.
precedencegroup NilCoalescingPrecedence {
    associativity: left
    higherThan: LogicalDisjunctionPrecedence
}

/// A custom infix operator with `LogicalDisjunctionPrecedence`.
///
/// This operator is used to execute closures based on whether an `Error` is `nil` or non-`nil`.
infix operator <~|: NilCoalescingPrecedence

extension Error {
    // MARK: - Error Logging Function
    
    /// Logs the provided error using its localized description.
    ///
    /// - Parameter error: The error to log. This uses the error's `localizedDescription` to print a user-friendly error message.
    func log() {
        print("Error: \(self.localizedDescription)")
    }
}

// MARK: - Error Handling Extensions

/// Error handling extension
///
public extension Error? where Self == (any Error)? {
    /// Executes a closure if the optional `Error` is non-`nil`.
    ///
    /// This operator allows you to execute a closure if an error exists. The closure is called without any parameters.
    ///
    /// ```swift
    /// let e: Error?
    ///
    /// { print("Oh no, error has occurred!") } <~| e
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The closure to execute if the `Error` is non-`nil`.
    ///   - rhs: The optional `Error` being checked.
    /// - Returns: The optional `Error` to allow further chaining if needed.
    @discardableResult
    static func <~| (lhs: @escaping (() -> Void), rhs: Error?) -> Error? {
        if !rhs.isNil { lhs() }
        return rhs
    }
    
    /// Executes a closure if the optional `Error` is non-`nil`, passing the `Error` to the closure.
    ///
    /// This operator allows you to execute a closure that takes an `Error` as a parameter if the error exists.
    ///
    /// ```swift
    /// let e: Error?
    ///
    /// { $0.log() } <~| e
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The closure to execute, which takes the non-`nil` `Error` as a parameter.
    ///   - rhs: The optional `Error` being checked.
    /// - Returns: The optional `Error` to allow further chaining if needed.
    @discardableResult
    static func <~| (lhs: @escaping ((Error) -> Void), rhs: Error?) -> Error? {
        if !rhs.isNil { lhs(rhs!) }
        return rhs
    }

    /// Executes a closure if the optional `Error` is `nil`.
    ///
    /// This operator allows you to execute a closure if no error exists (i.e., if the `Error` is `nil`).
    ///
    /// ```swift
    /// let e: Error?
    ///
    /// e |~> { print("All good!") }
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The optional `Error` being checked.
    ///   - rhs: The closure to execute if the `Error` is `nil`.
    static func |~> (lhs: Error?, rhs: @escaping (() -> Void)) {
        if lhs.isNil { rhs() }
    }
    
    /// Executes a closure if the optional `Error` is non-`nil`, passing the `Error` to the closure.
    ///
    /// This operator allows you to execute a closure that takes an `Error` as a parameter if the error exists.
    ///
    /// ```swift
    /// let e: Error?
    ///
    /// e |~> { $0.log() }
    /// ```
    ///
    /// - Note: This is just a different variation of <~| that passes the `Error`
    ///
    /// - Parameters:
    ///   - lhs: The optional `Error` being checked.
    ///   - rhs: The closure to execute, which takes the non-`nil` `Error` as a parameter.
    static func |~> (lhs: Error?, rhs: @escaping ((Error) -> Void)) {
        if !lhs.isNil { rhs(lhs!) }
    }
}

public extension Error where Self == (any Error) {
    @discardableResult
    static func <~| (lhs: @escaping (() -> Void), rhs: Error) -> Error {
        lhs()
        return rhs
    }
    
    @discardableResult
    static func <~| (lhs: @escaping ((Error) -> Void), rhs: Error) -> Error {
        lhs(rhs)
        return rhs
    }
    
    static func |~> (lhs: Error, rhs: @escaping (() -> Void)) {
        rhs()
    }
    static func |~> (lhs: Error, rhs: @escaping ((Error) -> Void)) {
        rhs(lhs)
    }
}
