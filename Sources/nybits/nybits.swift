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

public enum Endian {
    case little
    case big
}

public extension Data {
    func bit(at index: Int) -> Bool {
        let byteIndex = index / 8
        let bitIndex = index % 8
        guard byteIndex < self.count else { return false }
        return self[byteIndex].check(bitIndex)
    }
    
    func bits(in range: Range<Int>) -> [Bool] {
        return range.map { bit(at: $0) }
    }
    
    func to<T>(_ type: T.Type, endian: Endian = .little) -> T where T: FixedWidthInteger {
        switch endian {
        case .big:
            return withUnsafeBytes { $0.load(as: T.self) }.bigEndian
        case .little:
            return withUnsafeBytes { $0.load(as: T.self) }.littleEndian
        }
    }
    
    func toArray<T>(_ type: T.Type, endian: Endian = .little, in range: Range<Data.Index>? = nil) -> [T] where T: FixedWidthInteger {
        let range = range ?? self.startIndex..<self.endIndex
        let size = MemoryLayout<T>.size
        let count = range.count / size
        let value = withUnsafeBytes { buffer in
            Array(UnsafeBufferPointer(start: buffer.baseAddress?.advanced(by: range.lowerBound).assumingMemoryBound(to: T.self), count: count))
        }
        return value.map { endian == .big ? $0.bigEndian : $0.littleEndian }
    }
    
    func toPaddedArray<T>(_ type: T.Type) -> [T] where T: FixedWidthInteger {
        var paddedData = self
        let size = MemoryLayout<T>.size
        if paddedData.count % size != 0 {
            paddedData.append(contentsOf: [UInt8](repeating: 0, count: size - (paddedData.count % size)))
        }
        return paddedData.toArray(T.self)
    }
    
    var uint8: UInt8 { return to(UInt8.self) }
    var uint8Array: [UInt8] { return toArray(UInt8.self) }
    var uint8BoolArray: [Bool] { return uint8.asBoolArray }
    
    var uint16: UInt16 { return to(UInt16.self) }
    var uint16Array: [UInt16] { return toArray(UInt16.self) }
    var uint16BoolArray: [Bool] { return uint16.asBoolArray }
    
    var uint32: UInt32 { return to(UInt32.self) }
    var uint32Array: [UInt32] { return toArray(UInt32.self) }
    var uint32BoolArray: [Bool] { return uint32.asBoolArray }
    
    var uint64: UInt64 { return to(UInt64.self) }
    var uint64Array: [UInt64] { return toArray(UInt64.self) }
    var uint64BoolArray: [Bool] { return uint64.asBoolArray }
}

public extension Data {
    var hexString: String {
        map { String(format: "%02x", $0) }.joined()
    }
    
    var utf8String: String? {
        String(data: self, encoding: .utf8)
    }
    
    var utf16String: String? {
        String(data: self, encoding: .utf16)
    }
}
