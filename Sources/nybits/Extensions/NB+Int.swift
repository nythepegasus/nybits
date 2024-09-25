//
//  NB+Int.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

#if canImport(Foundation)
import Foundation

public extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    static func withSeparator(_ separator: String = ",", _ style: NumberFormatter.Style = .decimal) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = separator
        formatter.numberStyle = style
        return formatter
    }
}

public extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self)~ }
    
    func formattedWithSeparator(_ separator: String = ",", _ style: NumberFormatter.Style = .decimal) -> String {
        Formatter.withSeparator(separator, style).string(for: self)~
    }
}

#endif

public extension CGSize {
    /// Provides a `CGSize` with `width` `0.0` and `height` `0.0`
    static let zero = CGSize(width: 0.0, height: 0.0)
}

public extension CGPoint {
    /// Provides a `CGPoint` at `x` `0.0` and `y` `0.0`
    static let zero = CGPoint(x: 0.0, y: 0.0)
}

#if !DISABLE_FOUNDATION_DEFAULTABLE

// MARK: - Defaultable Conformances

extension CGSize: Defaultable {
    /// Provides a default value of `.zero` for `CGSize`
    public static var defaultValue: CGSize { .zero }
}

extension CGPoint: Defaultable {
    /// Provides a default value of `.zero` for `CGPoint`
    public static var defaultValue: CGPoint { .zero }
}

extension UInt: Defaultable {
    public static var defaultValue: UInt { 0 }
}

extension Int: Defaultable {
    public static var defaultValue: Int { -1 }
}

#endif

// MARK: - UInt Extensions

public extension FixedWidthInteger {
    
    /// Returns the boolean value of the bit at the specified position.
    ///
    /// This function checks if the bit at the given index is set (`1`) or not (`0`).
    ///
    /// - Parameter at: The bit index, where `0` is the least significant bit.
    /// - Returns: `true` if the bit at the specified index is set, otherwise `false`. If the index is out of range, returns `false`.
    @inlinable
    func bit(_ at: Int) -> Bool {
        guard 0...self.bitWidth - 1 ~= at else { return false }
        return self & (1 << at) != 0
    }
    
    /// Returns the bitwise representation of the integer as an array of `Bool` values.
    ///
    /// Each element in the array corresponds to a bit, where `true` means the bit is set (`1`) and `false` means the bit is not set (`0`).
    ///
    /// - Returns: An array of `Bool` values representing the bits of the integer.
    @inlinable
    var asBoolArray: [Bool] {
        return (0...self.bitWidth - 1).map { self.bit($0) }
    }
}

// MARK: - Custom Infix and Prefix Operators

/// Defines a custom infix operator `~` for range creation between two integers.
infix operator ~ : RangeFormationPrecedence

/// Defines a custom prefix operator `~` for creating a range starting from zero and ending at the specified integer.
prefix operator ~

public extension Int {
    
    /// A typealias for a range of integers.
    typealias IntRange = Range<Int>
    
    /// Deprecated method to create a range from `self` to `self + index`.
    ///
    /// - Parameter index: The upper bound offset for the range.
    /// - Returns: A range starting from `self` and extending by `index`.
    @available(*, deprecated, renamed: "~")
    @inlinable
    func off(_ index: Int) -> IntRange {
        self..<self+index
    }
    
    /// Custom infix operator `~` to create a range between two integers.
    ///
    /// - Parameters:
    ///   - lhs: The lower bound of the range.
    ///   - rhs: The upper bound of the range.
    /// - Returns: A range from `lhs` to `rhs`.
    @inlinable
    static func ~ (_ lhs: Int, _ rhs: Int) -> IntRange { lhs..<rhs }
    
    /// Custom prefix operator `~` to create a range starting from `0` and extending to the specified integer.
    ///
    /// - Example:
    /// ```swift
    /// let r = ~5
    /// ```
    ///
    /// - Parameter int: The upper bound of the range.
    /// - Returns: A range from `0` to `int`.
    @inlinable
    static prefix func ~ (_ int: Int) -> IntRange { 0..<0+int }
    
    // MARK: - Byte and Word Ranges
    
    /// A range representing a single byte (1 byte).
    ///
    /// Equivalent to `0..<1`.
    @inlinable
    var byte: IntRange { ~1 }
    
    /// A range representing a word (2 bytes).
    ///
    /// Equivalent to `0..<2`.
    @inlinable
    var word: IntRange { ~2 }
    
    /// A range representing a full word (4 bytes).
    ///
    /// Equivalent to `0..<4`.
    @inlinable
    var fword: IntRange { ~4 }
    
    /// A range representing a double full word (8 bytes).
    ///
    /// Equivalent to `0..<8`.
    @inlinable
    var dfword: IntRange { ~8 }
}
