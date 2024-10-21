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
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
    
    func formattedWithSeparator(_ separator: String = ",", _ style: NumberFormatter.Style = .decimal) -> String {
        Formatter.withSeparator(separator, style).string(for: self) ?? ""
    }
}

#endif

public extension Comparable {
    func clamped(_ f: Self, _ t: Self) -> Self { min(max(self, f), t) }
}

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
    
    /// Sets the bit at the specified index.
    /// - Parameter index: The index of the bit to set (0 is the least significant bit).
    /// - Returns: A copy of the integer with the specified bit set.
    func setBit(at index: Int) -> Self {
        guard 0..<self.bitWidth ~= index else { return self }
        return self | (1 << index)
    }

    /// Clears the bit at the specified index.
    /// - Parameter index: The index of the bit to clear (0 is the least significant bit).
    /// - Returns: A copy of the integer with the specified bit cleared.
    func clearBit(at index: Int) -> Self {
        guard 0..<self.bitWidth ~= index else { return self }
        return self & ~(1 << index)
    }

    /// Toggles the bit at the specified index.
    /// - Parameter index: The index of the bit to toggle (0 is the least significant bit).
    /// - Returns: A copy of the integer with the specified bit toggled.
    func toggleBit(at index: Int) -> Self {
        guard 0..<self.bitWidth ~= index else { return self }
        return self ^ (1 << index)
    }

    /// Creates an instance of a `FixedWidthInteger` from a hexadecimal string.
    /// - Parameter string: The hexadecimal string to convert.
    /// - Returns: An optional integer of the same type, or `nil` if the conversion fails.
    static func fromHex(_ string: String) -> Self? {
        return Self(string, radix: 16)
    }
    
    /// Returns the hexadecimal string representation of the integer.
    var hex: String { .init(format: "0x%0\(self.bitWidth / 4)X", UInt64(self)) }
}

public extension FixedWidthInteger {
    func addWithoutOverflow(_ other: Self) -> Self {
        let o = addingReportingOverflow(other)
        return o.overflow ? .max : o.partialValue
    }
    
    mutating func addingWithoutOverflow(_ other: Self) {
        self = addWithoutOverflow(other)
    }
    
    func subtractWithoutOverflow(_ other: Self) -> Self {
        let o = subtractingReportingOverflow(other)
        return o.overflow ? .min : o.partialValue
    }
    
    mutating func subtractingWithoutOverflow(_ other: Self) {
        self = subtractWithoutOverflow(other)
    }
}

public extension FixedWidthInteger {
  init<I>(littleEndianBytes iterator: inout I)
  where I: IteratorProtocol, I.Element == UInt8 {
    self = stride(from: 0, to: Self.bitWidth, by: 8).reduce(into: 0) {
      $0 |= Self(truncatingIfNeeded: iterator.next()!) &<< $1
    }
  }
  
  init<C>(littleEndianBytes bytes: C) where C: Collection, C.Element == UInt8 {
    precondition(bytes.count == (Self.bitWidth+7)/8)
    var iter = bytes.makeIterator()
    self.init(littleEndianBytes: &iter)
  }
}

// MARK: - Custom Infix and Prefix Operators

/// Defines a custom infix operator `~` for range creation between two integers.
infix operator ~ : RangeFormationPrecedence

/// Defines a custom prefix operator `~` for creating a range starting from zero and ending at the specified integer.
prefix operator ~

/// A typealias for a range of integers.
public typealias IntRange = Range<Int>

public extension Int {
    
    /// Deprecated method to create a range from `self` to `self + index`.
    ///
    /// - Parameter index: The upper bound offset for the range.
    /// - Returns: A range starting from `self` and extending by `index`.
    @inlinable
    func off(_ index: Int) -> IntRange { self..<self+index }
    
    /// Custom infix operator `~` to create a range between two integers.
    ///
    /// - Parameters:
    ///   - lhs: The lower bound of the range.
    ///   - rhs: The upper bound of the range.
    /// - Returns: A range from `lhs` to `rhs`.
    @inlinable
    static func ~ (_ lhs: Int, _ rhs: Int) -> IntRange { lhs..<lhs+rhs }
    
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

// MARK: - UInt extensions

public extension UInt64 {
    init?(_ array: [UInt32], endian: Endian = .little) {
        guard array.count >= 2 else { return nil }
        let a = (endian == .big) ? array.reversed() : array
        self = UInt64(a[0]) << 32 | UInt64(a[1])
    }
    
    init?(_ array: [UInt16], endian: Endian = .little) {
        guard array.count >= 4 else { return nil }
        let a = (endian == .big) ? array.reversed() : array
        self = UInt64(a[0]) << 48 | UInt64(a[1]) << 40 | UInt64(a[2]) << 32 | UInt64(a[3])
    }
    
    init?(_ array: [UInt8], endian: Endian = .little) {
        guard array.count >= 8 else { return nil }
        let a: [UInt8] = (endian == .big) ? array.reversed() : array
        self = UInt64(a[0]) << 56 | UInt64(a[1]) << 48 | UInt64(a[2]) << 40 | UInt64(a[3]) << 32 |
               UInt64(a[4]) << 24 | UInt64(a[5]) << 16 | UInt64(a[6]) << 8 | UInt64(a[7])
    }
    
    var asUInt32Array: [UInt32] {
        [
            UInt32((self >> 32) & 0xFFFFFFFF),
            UInt32(self & 0xFFFFFFFF)
        ]
    }
    
    var asUInt16Array: [UInt16] {
        [
            UInt16((self >> 48) & 0xFFFF),
            UInt16((self >> 32) & 0xFFFF),
            UInt16((self >> 16) & 0xFFFF),
            UInt16(self & 0xFFFF)
        ]
    }
    
    var asUInt8Array: [UInt8] {
        [
            UInt8((self >> 56) & 0xFF),
            UInt8((self >> 48) & 0xFF),
            UInt8((self >> 40) & 0xFF),
            UInt8((self >> 32) & 0xFF),
            UInt8((self >> 24) & 0xFF),
            UInt8((self >> 16) & 0xFF),
            UInt8((self >> 8) & 0xFF),
            UInt8(self & 0xFF)
        ]
    }
    
    var int64: Int64 { Int64(bitPattern: self) }
}

public extension UInt32 {
    init?(_ array: [UInt16], endian: Endian = .little) {
        guard array.count >= 2 else { return nil }
        let a = (endian == .big) ? array.reversed() : array
        self = (UInt32(a[0]) << 16) | UInt32(a[1])
    }
    
    init?(_ array: [UInt8], endian: Endian = .little) {
        guard array.count >= 4 else { return nil }
        let a = (endian == .big) ? array.reversed() : array
        self = (UInt32(a[0]) << 24) | (UInt32(a[1]) << 16) | (UInt32(a[2]) << 8) | UInt32(a[3])
    }
    
    var asUInt16Array: [UInt16] {
        [
            UInt16((self >> 16) & 0xFFFF),
            UInt16(self & 0xFFFF)
        ]
    }
    
    var asUInt8Array: [UInt8] {
        [
            UInt8((self >> 24) & 0xFF),
            UInt8((self >> 16) & 0xFF),
            UInt8((self >> 8) & 0xFF),
            UInt8(self & 0xFF)
        ]
    }
    
    var int32: Int32 { Int32(bitPattern: self) }
}

public extension UInt16 {
    init?(_ array: [UInt8], endian: Endian = .little) {
        guard array.count >= 2 else { return nil }
        let a = (endian == .big) ? array.reversed() : array
        self = (UInt16(a[0]) << 8) | UInt16(a[1])
    }
    
    var asUInt8Array: [UInt8] {
        [
            UInt8((self >> 8) & 0xFF),
            UInt8(self & 0xFF)
        ]
    }
    
    var int16: Int16 { Int16(bitPattern: self) }
}

public extension UInt8 {
    var int8: Int8 { Int8(bitPattern: self) }
}
