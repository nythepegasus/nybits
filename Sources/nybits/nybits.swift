// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public typealias Byte = UInt8
public typealias Word = UInt16
public typealias FWord = UInt32
public typealias DFWord = UInt64

public extension FixedWidthInteger where Self: UnsignedInteger {
    func check(_ bit: Int) -> Bool {
        guard 0...self.bitWidth - 1 ~= bit else { return false }
        return self & (1 << bit) != 0
    }
    
    var asBoolArray: [Bool] {
        return (0...self.bitWidth - 1).map { self.check($0) }
    }
}

public extension Data {
    func to<T>(_ type: T.Type) -> T where T: FixedWidthInteger {
        return withUnsafeBytes { $0.load(as: T.self) }
    }
    
    func toArray<T>(_ type: T.Type) -> [T] where T: FixedWidthInteger {
        let range = self.startIndex..<self.endIndex
        let size = MemoryLayout<T>.size
        let count = range.count / size
        return withUnsafeBytes { buffer in
            Array(UnsafeBufferPointer(start: buffer.baseAddress?.advanced(by: range.lowerBound).assumingMemoryBound(to: T.self), count: count))
        }
    }
    
    var uint8: UInt8 { return to(UInt8.self) }
    var uint8BoolArray: [Bool] { return uint8.asBoolArray }
    
    var uint16: UInt16 { return to(UInt16.self) }
    var uint16BoolArray: [Bool] { return uint16.asBoolArray }
    
    var uint32: UInt32 { return to(UInt32.self) }
    var uint32BoolArray: [Bool] { return uint32.asBoolArray }
    
    var uint64: UInt64 { return to(UInt64.self) }
    var uint64BoolArray: [Bool] { return uint64.asBoolArray }
}
