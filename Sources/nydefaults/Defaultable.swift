//
//  Defaultable.swift
//  nybits
//
//  Created by ny on 9/25/24.
//

import nybits
import Foundation

// MARK: - ny's Defaultable Foundation Extensions

extension Bool: Defaultable {
    /// Provides a default value of 'false' for `Bool`
    public static var defaultValue: Bool { false }
}

extension Int: Defaultable {
    /// Provides a default value of '-1' for `Int`
    public static var defaultValue: Int { -1 }
}

extension Int8: Defaultable {
    /// Provides a default value of '0' for `Int8`
    public static var defaultValue: Int8 { 0 }
}

extension Int16: Defaultable {
    /// Provides a default value of '0' for `Int16`
    public static var defaultValue: Int16 { 0 }
}

extension Int32: Defaultable {
    /// Provides a default value of '0' for `Int32`
    public static var defaultValue: Int32 { 0 }
}

extension Int64: Defaultable {
    /// Provides a default value of '0' for `UInt8`
    public static var defaultValue: Int64 { 0 }
}

extension UInt: Defaultable {
    /// Provides a default value of '0' for `UInt`
    public static var defaultValue: UInt { 0 }
}

extension UInt8: Defaultable {
    /// Provides a default value of '0' for `UInt8`
    public static var defaultValue: UInt8 { 0 }
}

extension UInt16: Defaultable {
    /// Provides a default value of '0' for `UInt16`
    public static var defaultValue: UInt16 { 0 }
}

extension UInt32: Defaultable {
    /// Provides a default value of '0' for `UInt32`
    public static var defaultValue: UInt32 { 0 }
}

extension UInt64: Defaultable {
    /// Provides a default value of '0' for `UInt64`
    public static var defaultValue: UInt64 { 0 }
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

#if canImport(CoreGraphics)

import CoreGraphics

extension CGSize: Defaultable {
    /// Provides a default value of `.zero` for `CGSize`
    public static var defaultValue: CGSize { .zero }
}

extension CGPoint: Defaultable {
    /// Provides a default value of `.zero` for `CGPoint`
    public static var defaultValue: CGPoint { .zero }
}

#else

extension CGSize: Defaultable {
    static let zero = CGSize(width: 0, height: 0)
    /// Provides a default value of `.zero` for `CGSize`
    public static var defaultValue: CGSize { .zero }
}

extension CGPoint: Defaultable {
    static let zero = CGPoint(x: 0, y: 0)
    /// Provides a default value of `.zero` for `CGPoint`
    public static var defaultValue: CGPoint { .zero }
}

#endif

extension Foundation.Data: Defaultable {
    public static var defaultValue: Foundation.Data { .init() }
}

extension Character: Defaultable {
    /// Provides a default value of a space character `" "` for `Character`
    public static var defaultValue: Character { " " }
}

extension String: Defaultable {
    public static var defaultValue: String { "" }
}

extension URL: Defaultable {
    public static var defaultValue: URL { URL(staticString: "https://nythepegas.us") }
}

extension Array: Defaultable {
    /// Provides an empty `Array` as the default value for `Array`
    public static var defaultValue: Array<Element> { [] }
}

extension Dictionary: Defaultable {
    /// Provides an empty `Dictionary` as the default value for `Dictionary`
    public static var defaultValue: Dictionary<Key, Value> { [:] }
}

extension Date: Defaultable {
    public static var defaultValue: Date { Date() }
}

extension Set: Defaultable {
    /// Provides an empty `Set` as the default value for `Set`
    public static var defaultValue: Set<Element> { [] }
}

extension UUID: Defaultable {
    /// Provides a new `UUID` as the default value for `UUID`
    public static var defaultValue: UUID { UUID() }
}

