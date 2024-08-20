// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public extension Data {
    typealias Byte = UInt8
    typealias Word = UInt16
    typealias Dword = UInt32
    typealias Qword = UInt64
    
}

public extension UInt8 {
    func check(_ bit: Int) -> Bool {
        guard 0..<8 ~= bit else { return false }
        return self & (1 << bit) != 0
    }
}

