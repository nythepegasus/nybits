//
//  NB+Int.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

// MARK: UInt extensions

public extension FixedWidthInteger {
    @inlinable
    func bit(_ at: Int) -> Bool {
        guard 0...self.bitWidth - 1 ~= at else { return false }
        return self & (1 << at) != 0
    }

    @inlinable
    var asBoolArray: [Bool] {
        return (0...self.bitWidth - 1).map { self.bit($0) }
    }
}

infix   operator ~
prefix  operator ~

public extension Int {
    typealias IntRange = Range<Int>
    
    @available(*, deprecated, renamed: "~")
    @inlinable
    func off(_ index: Int) -> IntRange {
        self..<self+index
    }
    
    @inlinable
    static func ~ (_ lhs: Int, _ rhs: Int) -> IntRange { lhs..<rhs }
    
    @inlinable
    static prefix func ~ (_ int: Int) -> IntRange { 0..<0+int }

    @inlinable
    var byte: IntRange { ~1 }
    @inlinable
    var word: IntRange { ~2 }
    @inlinable
    var fword: IntRange { ~4 }
    @inlinable
    var dfword: IntRange { ~8 }
}
