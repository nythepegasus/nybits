// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public typealias Byte = UInt8
public typealias Word = UInt16
public typealias FWord = UInt32
public typealias DFWord = UInt64

public extension FixedWidthInteger where Self: UnsignedInteger {
    func check(_ bit: Int) -> Bool {
        guard 0...self.bitWidth ~= bit else { return false }
        return self & (1 << bit) != 0
    }
    
    var asBoolArray: [Bool] {
        return (0...self.bitWidth).map { self.check($0) }
    }
}
