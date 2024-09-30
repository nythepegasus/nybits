//
//  NB+String.swift
//  nybits
//
//  Created by ny on 9/24/24.
//

import Foundation

// MARK: - Data String Methods

public extension Data {
    
    /// A hexadecimal string representation of the `Data` object.
    ///
    /// Converts each byte in the `Data` object to a two-character hexadecimal string and joins them together.
    /// - Returns: A `String` representing the `Data` in hexadecimal format.
    @inlinable
    var hexString: String { map { String(format: "%02x", $0) }.joined() }
    
    /// An ASCII string representation of the `Data` object, if valid.
    ///
    /// Attempts to create a string from the `Data` using ASCII encoding. If the data cannot be represented as a valid ASCII string, this property returns `nil`.
    /// - Returns: An optional `String` if the `Data` can be converted to ASCII, otherwise `nil`.
    @inlinable
    var asciiString: String? { String(data: self, encoding: .ascii) }
    
    /// A UTF-8 string representation of the `Data` object, if valid.
    ///
    /// Attempts to create a string from the `Data` using UTF-8 encoding. If the data cannot be represented as a valid UTF-8 string, this property returns `nil`.
    /// - Returns: An optional `String` if the `Data` can be converted to UTF-8, otherwise `nil`.
    @inlinable
    var utf8String: String? { String(data: self, encoding: .utf8) }
    
    /// A UTF-16 string representation of the `Data` object, if valid.
    ///
    /// Attempts to create a string from the `Data` using UTF-16 encoding. If the data cannot be represented as a valid UTF-16 string, this property returns `nil`.
    /// - Returns: An optional `String` if the `Data` can be converted to UTF-16, otherwise `nil`.
    @inlinable
    var utf16String: String? { String(data: self, encoding: .utf16) }
}

public extension String {
    
    /// Initializes a localized formatted string using a format string and optional arguments.
    ///
    /// This initializer uses `NSLocalizedString` to look up a localized version of the `formatted` string and then applies the provided arguments to it.
    ///
    /// - Parameters:
    ///   - formatted: The format string, which can contain placeholders for arguments.
    ///   - comment: An optional comment used for context in localization files. If not provided, defaults to `nil`.
    ///   - args: A variadic list of arguments to apply to the format string.
    ///
    init(formatted: String, comment: String? = nil, _ args: CVarArg...) {
        self.init(format: NSLocalizedString(formatted, comment: comment ?? ""), arguments: args)
    }
    
    subscript(range: IntRange) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start..<end])
    }
    
    /// Converts the `String` into a `Data` object using the specified encoding.
    ///
    /// - Parameter encoding: The string encoding to use for the conversion. Defaults to `.utf8`.
    /// - Returns: A `Data` object containing the string's data representation in the specified encoding.
    ///
    /// - Note: The conversion force unwraps the result, so it is important to ensure the string can be converted using the specified encoding.
    func data(_ encoding: String.Encoding = .utf8) -> Data { data(using: encoding)! }
    
    func nsRange(from range: Range<String.Index>) -> NSRange { NSRange(range, in: self) }

    var titleCased: String {
        replacingOccurrences(of: #"[A-Za-z]"#, with: " $0", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
    
    var camelCased: String {
        let words = self.lowercased().split(separator: " ")
        let firstWord = words.first?.lowercased()
        let capitalizedWords = words.dropFirst().map { $0.capitalized }
        return ([firstWord ?? ""] + capitalizedWords).joined()
    }
}
