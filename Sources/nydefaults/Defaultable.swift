//
//  Defaultable.swift
//  nybits
//
//  Created by ny on 9/25/24.
//

import nybits
import Foundation

// MARK: - ny's Defaultable Foundation Extensions

extension Bool: @retroactive Defaultable {
    /// Provides a default value of 'false' for `Bool`
    public static var defaultValue: Bool { false }
}

extension Int: @retroactive Defaultable {
    /// Provides a default value of '-1' for `Int`
    public static var defaultValue: Int { -1 }
}

extension Int8: @retroactive Defaultable {
    /// Provides a default value of '0' for `Int8`
    public static var defaultValue: Int8 { 0 }
}

extension Int16: @retroactive Defaultable {
    /// Provides a default value of '0' for `Int16`
    public static var defaultValue: Int16 { 0 }
}

extension Int32: @retroactive Defaultable {
    /// Provides a default value of '0' for `Int32`
    public static var defaultValue: Int32 { 0 }
}

extension Int64: @retroactive Defaultable {
    /// Provides a default value of '0' for `UInt8`
    public static var defaultValue: Int64 { 0 }
}

extension UInt: @retroactive Defaultable {
    /// Provides a default value of '0' for `UInt`
    public static var defaultValue: UInt { 0 }
}

extension UInt8: @retroactive Defaultable {
    /// Provides a default value of '0' for `UInt8`
    public static var defaultValue: UInt8 { 0 }
}

extension UInt16: @retroactive Defaultable {
    /// Provides a default value of '0' for `UInt16`
    public static var defaultValue: UInt16 { 0 }
}

extension UInt32: @retroactive Defaultable {
    /// Provides a default value of '0' for `UInt32`
    public static var defaultValue: UInt32 { 0 }
}

extension UInt64: @retroactive Defaultable {
    /// Provides a default value of '0' for `UInt64`
    public static var defaultValue: UInt64 { 0 }
}

extension Float: @retroactive Defaultable {
    /// Provides a default value of `0.0` for `Float`
    public static var defaultValue: Float { 0.0 }
}

extension Double: @retroactive Defaultable {
    /// Provides a default value of `0.0` for `Double`
    public static var defaultValue: Double { 0.0 }
}

extension CGFloat: @retroactive Defaultable {
    /// Provides a default value of `0.0` for `CGFloat`
    public static var defaultValue: CGFloat { 0.0 }
}

extension CGSize: @retroactive Defaultable {
    /// Provides a default value of `.zero` for `CGSize`
    public static var defaultValue: CGSize { .zero }
}

extension CGPoint: @retroactive Defaultable {
    /// Provides a default value of `.zero` for `CGPoint`
    public static var defaultValue: CGPoint { .zero }
}

extension Foundation.Data: @retroactive Defaultable {
    public static var defaultValue: Foundation.Data { .init() }
}

extension Character: @retroactive Defaultable {
    /// Provides a default value of a space character `" "` for `Character`
    public static var defaultValue: Character { " " }
}

extension String: @retroactive Defaultable {
    public static var defaultValue: String { "" }
}

extension URL: @retroactive Defaultable {
    public static var defaultValue: URL { URL(staticString: "https://nythepegas.us") }
}

extension Array: @retroactive Defaultable {
    /// Provides an empty `Array` as the default value for `Array`
    public static var defaultValue: Array<Element> { [] }
}

extension Dictionary: @retroactive Defaultable {
    /// Provides an empty `Dictionary` as the default value for `Dictionary`
    public static var defaultValue: Dictionary<Key, Value> { [:] }
}

extension Date: @retroactive Defaultable {
    public static var defaultValue: Date { Date() }
}

extension Set: @retroactive Defaultable {
    /// Provides an empty `Set` as the default value for `Set`
    public static var defaultValue: Set<Element> { [] }
}

extension UUID: @retroactive Defaultable {
    /// Provides a new `UUID` as the default value for `UUID`
    public static var defaultValue: UUID { UUID() }
}

