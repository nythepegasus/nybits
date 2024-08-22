//
//  NB+Data.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

// MARK: Generic Data extension

public extension Data {
    enum Endian {
        case little
        case big
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
}

// MARK: Data U/Int extension

public extension Data {
    typealias Byte = UInt8
    typealias Word = UInt16
    typealias FWord = UInt32
    typealias DFWord = UInt64
    
    typealias SByte = Int8
    typealias SWord = Int16
    typealias SFWord = Int32
    typealias SDFWord = Int64
    
    @inlinable
    func byte(_ index: Int) -> Byte { subdata(in: index.byte).uint8 }
    @inlinable
    func word(_ index: Int) -> Word { subdata(in: index.word).uint16 }
    @inlinable
    func fword(_ index: Int) -> FWord { subdata(in: index.fword).uint32 }
    @inlinable
    func dfword(_ index: Int) -> DFWord { subdata(in: index.dfword).uint64 }
    
    @inlinable
    func sbyte(_ index: Int) -> SByte { subdata(in: index.byte).int8 }
    @inlinable
    func sword(_ index: Int) -> SWord { subdata(in: index.word).int16 }
    @inlinable
    func sfword(_ index: Int) -> SFWord { subdata(in: index.fword).int32 }
    @inlinable
    func sdfword(_ index: Int) -> SDFWord { subdata(in: index.dfword).int64 }

    @inlinable
    func bit(at index: Int) -> Bool {
        let byteIndex = index / 8
        let bitIndex = index % 8
        guard byteIndex < self.count else { return false }
        return self[byteIndex].bit(bitIndex)
    }

    @inlinable
    func bits(in range: Range<Int>) -> [Bool] {
        range.map { bit(at: $0) }
    }

    @inlinable
    var uint8: UInt8 { to(UInt8.self) }
    @inlinable
    var uint8Array: [UInt8] { toArray(UInt8.self) }
    @inlinable
    var uint8BoolArray: [Bool] { uint8.asBoolArray }

    @inlinable
    var uint16: UInt16 { to(UInt16.self) }
    @inlinable
    var uint16Array: [UInt16] { toArray(UInt16.self) }
    @inlinable
    var uint16BoolArray: [Bool] { uint16.asBoolArray }

    @inlinable
    var uint32: UInt32 { to(UInt32.self) }
    @inlinable
    var uint32Array: [UInt32] { toArray(UInt32.self) }
    @inlinable
    var uint32BoolArray: [Bool] { uint32.asBoolArray }

    @inlinable
    var uint64: UInt64 { to(UInt64.self) }
    @inlinable
    var uint64Array: [UInt64] { toArray(UInt64.self) }
    @inlinable
    var uint64BoolArray: [Bool] { uint64.asBoolArray }
    
    @inlinable
    var int8: Int8 { to(Int8.self) }
    @inlinable
    var int8Array: [Int8] { toArray(Int8.self) }
    @inlinable
    var int8BoolArray: [Bool] { int8.asBoolArray }
    
    @inlinable
    var int16: Int16 { to(Int16.self) }
    @inlinable
    var int16Array: [Int16] { toArray(Int16.self) }
    @inlinable
    var int16BoolArray: [Bool] { int16.asBoolArray }

    @inlinable
    var int32: Int32 { to(Int32.self) }
    @inlinable
    var int32Array: [Int32] { toArray(Int32.self) }
    @inlinable
    var int32BoolArray: [Bool] { int32.asBoolArray }

    @inlinable
    var int64: Int64 { to(Int64.self) }
    @inlinable
    var int64Array: [Int64] { toArray(Int64.self) }
    @inlinable
    var int64BoolArray: [Bool] { int64.asBoolArray }
}

// MARK: String methods

public extension Data {
    @inlinable
    var hexString: String { map { String(format: "%02x", $0) }.joined() }

    @inlinable
    var asciiString: String? { String(data: self, encoding: .ascii) }

    @inlinable
    var utf8String: String? { String(data: self, encoding: .utf8) }

    @inlinable
    var utf16String: String? { String(data: self, encoding: .utf16) }
}

public extension String {
    init(formatted: String, comment: String? = nil, _ args: CVarArg...) {
        self.init(format: NSLocalizedString(formatted, comment: comment ?? ""), args)
    }
    
    func data(_ encoding: String.Encoding = .utf8) -> Data { data(using: encoding)! }
}
