// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public typealias Byte = UInt8
public typealias Word = UInt16
public typealias FWord = UInt32
public typealias DFWord = UInt64

public extension FixedWidthInteger where Self: UnsignedInteger {
    @inlinable
    func check(_ bit: Int) -> Bool {
        guard 0...self.bitWidth - 1 ~= bit else { return false }
        return self & (1 << bit) != 0
    }
    
    @inlinable
    var asBoolArray: [Bool] {
        return (0...self.bitWidth - 1).map { self.check($0) }
    }
}

public enum Endian {
    case little
    case big
}

public extension Array where Element: FixedWidthInteger {
    @inlinable
    func toString(endian: Endian = .little, encoding: String.Encoding = .utf8) -> String? {
        let byteWidth = Element.bitWidth / 8
        
        let bytes = self.flatMap { value -> [UInt8] in
            let byte = endian == .big ? value.bigEndian : value.littleEndian
            return (0..<byteWidth).map { index in
                UInt8((byte >> (8 * (byteWidth - 1 - index))) & 0xff)
            }
        }
        return String(bytes: bytes, encoding: encoding)
    }
}

public extension Data {
    @inlinable
    func bit(at index: Int) -> Bool {
        let byteIndex = index / 8
        let bitIndex = index % 8
        guard byteIndex < self.count else { return false }
        return self[byteIndex].check(bitIndex)
    }
    
    @inlinable
    func bits(in range: Range<Int>) -> [Bool] {
        return range.map { bit(at: $0) }
    }
    
    @inlinable
    @_specialize(where T == UInt8)
    @_specialize(where T == UInt16)
    @_specialize(where T == UInt32)
    @_specialize(where T == UInt64)
    func to<T>(_ type: T.Type, endian: Endian = .little) -> T where T: FixedWidthInteger {
        let value = withUnsafeBytes { $0.load(as: T.self) }
        return endian == .big ? value.bigEndian : value.littleEndian
    }
    
    @inlinable
    @_specialize(where T == UInt8)
    @_specialize(where T == UInt16)
    @_specialize(where T == UInt32)
    @_specialize(where T == UInt64)
    func toArray<T>(_ type: T.Type, endian: Endian = .little, in range: Range<Data.Index>? = nil) -> [T] where T: FixedWidthInteger {
        let range = range ?? self.startIndex..<self.endIndex
        let size = MemoryLayout<T>.size
        let count = range.count / size
        let value = withUnsafeBytes { buffer in
            Array(UnsafeBufferPointer(start: buffer.baseAddress?.advanced(by: range.lowerBound).assumingMemoryBound(to: T.self), count: count))
        }
        return value.map { endian == .big ? $0.bigEndian : $0.littleEndian }
    }
    
    @inlinable
    @_specialize(where T == UInt8)
    @_specialize(where T == UInt16)
    @_specialize(where T == UInt32)
    @_specialize(where T == UInt64)
    func toPaddedArray<T>(_ type: T.Type) -> [T] where T: FixedWidthInteger {
        var paddedData = self
        let size = MemoryLayout<T>.size
        if paddedData.count % size != 0 {
            paddedData.append(contentsOf: [UInt8](repeating: 0, count: size - (paddedData.count % size)))
        }
        return paddedData.toArray(T.self)
    }
    
    @inlinable
    var uint8: UInt8 { return to(UInt8.self) }
    @inlinable
    var uint8Array: [UInt8] { return toArray(UInt8.self) }
    @inlinable
    var uint8BoolArray: [Bool] { return uint8.asBoolArray }
    
    @inlinable
    var uint16: UInt16 { return to(UInt16.self) }
    @inlinable
    var uint16Array: [UInt16] { return toArray(UInt16.self) }
    @inlinable
    var uint16BoolArray: [Bool] { return uint16.asBoolArray }
    
    @inlinable
    var uint32: UInt32 { return to(UInt32.self) }
    @inlinable
    var uint32Array: [UInt32] { return toArray(UInt32.self) }
    @inlinable
    var uint32BoolArray: [Bool] { return uint32.asBoolArray }
    
    @inlinable
    var uint64: UInt64 { return to(UInt64.self) }
    @inlinable
    var uint64Array: [UInt64] { return toArray(UInt64.self) }
    @inlinable
    var uint64BoolArray: [Bool] { return uint64.asBoolArray }
}

public extension Data {
    @inlinable
    var hexString: String {
        map { String(format: "%02x", $0) }.joined()
    }
    
    @inlinable
    var utf8String: String? {
        String(data: self, encoding: .utf8)
    }
    
    @inlinable
    var utf16String: String? {
        String(data: self, encoding: .utf16)
    }
}
