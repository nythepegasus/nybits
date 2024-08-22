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

public extension Int {
    typealias IntRange = Range<Int>
    
    @inlinable
    func off(_ index: Int) -> IntRange {
        self..<self+index
    }

    @inlinable
    var byte: IntRange { off(1) }
    @inlinable
    var word: IntRange { off(2) }
    @inlinable
    var fword: IntRange { off(4) }
    @inlinable
    var dfword: IntRange { off(8) }
}
