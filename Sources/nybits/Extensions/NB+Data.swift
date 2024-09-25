//
//  NB+Data.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

// MARK: Generic Data extension

public extension Foundation.Data {
    
    /// Represents the byte order (endianness) used for reading binary data.
    enum Endian {
        /// Little-endian format where the least significant byte is stored first.
        case little
        /// Big-endian format where the most significant byte is stored first.
        case big
    }

    /// Converts the data into a single value of the specified type, interpreting it in the given endianness.
    ///
    /// This function extracts a value from the `Data` object by loading its raw bytes as the specified fixed-width integer type. The data is interpreted according to the specified byte order (`little` or `big` endian).
    ///
    /// - Parameters:
    ///   - type: The type of the value to extract. Must conform to `FixedWidthInteger`.
    ///   - endian: The byte order in which to interpret the data. Defaults to `.little`.
    /// - Returns: The extracted value of type `T`.
    ///
    /// - Note: The function is specialized for `UInt8`, `UInt16`, `UInt32`, and `UInt64`.
    @inlinable
    @_specialize(where T == UInt8)
    @_specialize(where T == UInt16)
    @_specialize(where T == UInt32)
    @_specialize(where T == UInt64)
    func to<T>(_ type: T.Type, endian: Endian = .little) -> T where T: FixedWidthInteger {
        let value = withUnsafeBytes { $0.load(as: T.self) }
        return endian == .big ? value.bigEndian : value.littleEndian
    }

    /// Converts a range of the data into an array of values of the specified type, interpreting them in the given endianness.
    ///
    /// This function reads multiple values from a specified range within the `Data` object, and returns them as an array. Each value is interpreted as the specified type and in the given byte order.
    ///
    /// - Parameters:
    ///   - type: The type of the values to extract. Must conform to `FixedWidthInteger`.
    ///   - endian: The byte order in which to interpret the data. Defaults to `.little`.
    ///   - range: The range of the `Data` to read. If `nil`, the entire `Data` object is used.
    /// - Returns: An array of values of type `T`, each interpreted according to the specified endianness.
    ///
    /// - Note: The function is specialized for `UInt8`, `UInt16`, `UInt32`, and `UInt64`.
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

    /// Converts the data into an array of values of the specified type, padding the data if necessary.
    ///
    /// This function pads the data to a multiple of the size of the type `T`, and then reads the values as an array. If the data length is not a multiple of the size of `T`, the data is padded with zeros.
    ///
    /// - Parameter type: The type of the values to extract. Must conform to `FixedWidthInteger`.
    /// - Returns: An array of values of type `T`, with the data padded if necessary.
    ///
    /// - Note: The function is specialized for `UInt8`, `UInt16`, `UInt32`, and `UInt64`.
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


// MARK: Data Unsigned and Signed Integer Type extensions

public extension Foundation.Data {
    
    // MARK: - Typealiases for Unsigned and Signed Integer Types
    
    /// A byte, represented as an unsigned 8-bit integer.
    typealias Byte = UInt8
    
    /// A word, represented as an unsigned 16-bit integer.
    typealias Word = UInt16
    
    /// A full word, represented as an unsigned 32-bit integer.
    typealias FWord = UInt32
    
    /// A double full word, represented as an unsigned 64-bit integer.
    typealias DFWord = UInt64
    
    /// A signed byte, represented as a signed 8-bit integer.
    typealias SByte = Int8
    
    /// A signed word, represented as a signed 16-bit integer.
    typealias SWord = Int16
    
    /// A signed full word, represented as a signed 32-bit integer.
    typealias SFWord = Int32
    
    /// A signed double full word, represented as a signed 64-bit integer.
    typealias SDFWord = Int64
    
    // MARK: - Byte and Word Accessors
    
    /// Returns the byte at the specified index.
    ///
    /// - Parameter index: The index of the byte in the data.
    /// - Returns: The byte (`UInt8`) at the specified index.
    @inlinable
    func byte(_ index: Int) -> Byte { subdata(in: index.byte).uint8 }
    
    /// Returns the word at the specified index.
    ///
    /// - Parameter index: The index of the word in the data.
    /// - Returns: The word (`UInt16`) at the specified index.
    @inlinable
    func word(_ index: Int) -> Word { subdata(in: index.word).uint16 }
    
    /// Returns the full word at the specified index.
    ///
    /// - Parameter index: The index of the full word in the data.
    /// - Returns: The full word (`UInt32`) at the specified index.
    @inlinable
    func fword(_ index: Int) -> FWord { subdata(in: index.fword).uint32 }
    
    /// Returns the double full word at the specified index.
    ///
    /// - Parameter index: The index of the double full word in the data.
    /// - Returns: The double full word (`UInt64`) at the specified index.
    @inlinable
    func dfword(_ index: Int) -> DFWord { subdata(in: index.dfword).uint64 }
    
    // MARK: - Signed Integer Accessors
    
    /// Returns the signed byte at the specified index.
    ///
    /// - Parameter index: The index of the signed byte in the data.
    /// - Returns: The signed byte (`Int8`) at the specified index.
    @inlinable
    func sbyte(_ index: Int) -> SByte { subdata(in: index.byte).int8 }
    
    /// Returns the signed word at the specified index.
    ///
    /// - Parameter index: The index of the signed word in the data.
    /// - Returns: The signed word (`Int16`) at the specified index.
    @inlinable
    func sword(_ index: Int) -> SWord { subdata(in: index.word).int16 }
    
    /// Returns the signed full word at the specified index.
    ///
    /// - Parameter index: The index of the signed full word in the data.
    /// - Returns: The signed full word (`Int32`) at the specified index.
    @inlinable
    func sfword(_ index: Int) -> SFWord { subdata(in: index.fword).int32 }
    
    /// Returns the signed double full word at the specified index.
    ///
    /// - Parameter index: The index of the signed double full word in the data.
    /// - Returns: The signed double full word (`Int64`) at the specified index.
    @inlinable
    func sdfword(_ index: Int) -> SDFWord { subdata(in: index.dfword).int64 }
    
    // MARK: - Bitwise Operations
    
    /// Returns the bit at the specified bit index.
    ///
    /// - Parameter index: The bit index in the data.
    /// - Returns: `true` if the bit is set, `false` otherwise.
    @inlinable
    func bit(at index: Int) -> Bool {
        let byteIndex = index / 8
        let bitIndex = index % 8
        guard byteIndex < self.count else { return false }
        return self[byteIndex].bit(bitIndex)
    }
    
    /// Returns an array of bits in the specified range.
    ///
    /// - Parameter range: The range of bit indices.
    /// - Returns: An array of `Bool` values, each representing a bit in the range.
    @inlinable
    func bits(in range: Range<Int>) -> [Bool] {
        range.map { bit(at: $0) }
    }
    
    // MARK: - Unsigned Integer Accessors
    
    /// The `UInt8` value at the start of the data.
    @inlinable
    var uint8: UInt8 { to(UInt8.self) }
    
    /// An array of `UInt8` values representing the data.
    @inlinable
    var uint8Array: [UInt8] { toArray(UInt8.self) }
    
    /// An array of boolean values representing each bit of the `UInt8` data.
    @inlinable
    var uint8BoolArray: [Bool] { uint8.asBoolArray }
    
    /// The `UInt16` value at the start of the data.
    @inlinable
    var uint16: UInt16 { to(UInt16.self) }
    
    /// An array of `UInt16` values representing the data.
    @inlinable
    var uint16Array: [UInt16] { toArray(UInt16.self) }
    
    /// An array of boolean values representing each bit of the `UInt16` data.
    @inlinable
    var uint16BoolArray: [Bool] { uint16.asBoolArray }
    
    /// The `UInt32` value at the start of the data.
    @inlinable
    var uint32: UInt32 { to(UInt32.self) }
    
    /// An array of `UInt32` values representing the data.
    @inlinable
    var uint32Array: [UInt32] { toArray(UInt32.self) }
    
    /// An array of boolean values representing each bit of the `UInt32` data.
    @inlinable
    var uint32BoolArray: [Bool] { uint32.asBoolArray }
    
    /// The `UInt64` value at the start of the data.
    @inlinable
    var uint64: UInt64 { to(UInt64.self) }
    
    /// An array of `UInt64` values representing the data.
    @inlinable
    var uint64Array: [UInt64] { toArray(UInt64.self) }
    
    /// An array of boolean values representing each bit of the `UInt64` data.
    @inlinable
    var uint64BoolArray: [Bool] { uint64.asBoolArray }
    
    // MARK: - Signed Integer Accessors
    
    /// The `Int8` value at the start of the data.
    @inlinable
    var int8: Int8 { to(Int8.self) }
    
    /// An array of `Int8` values representing the data.
    @inlinable
    var int8Array: [Int8] { toArray(Int8.self) }
    
    /// An array of boolean values representing each bit of the `Int8` data.
    @inlinable
    var int8BoolArray: [Bool] { int8.asBoolArray }
    
    /// The `Int16` value at the start of the data.
    @inlinable
    var int16: Int16 { to(Int16.self) }
    
    /// An array of `Int16` values representing the data.
    @inlinable
    var int16Array: [Int16] { toArray(Int16.self) }
    
    /// An array of boolean values representing each bit of the `Int16` data.
    @inlinable
    var int16BoolArray: [Bool] { int16.asBoolArray }
    
    /// The `Int32` value at the start of the data.
    @inlinable
    var int32: Int32 { to(Int32.self) }
    
    /// An array of `Int32` values representing the data.
    @inlinable
    var int32Array: [Int32] { toArray(Int32.self) }
    
    /// An array of boolean values representing each bit of the `Int32` data.
    @inlinable
    var int32BoolArray: [Bool] { int32.asBoolArray }
    
    /// The `Int64` value at the start of the data.
    @inlinable
    var int64: Int64 { to(Int64.self) }
    
    /// An array of `Int64` values representing the data.
    @inlinable
    var int64Array: [Int64] { toArray(Int64.self) }
    
    /// An array of boolean values representing each bit of the `Int64` data.
    @inlinable
    var int64BoolArray: [Bool] { int64.asBoolArray }
}
