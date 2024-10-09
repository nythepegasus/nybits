//
//  NB+URL.swift
//  nybits
//
//  Created by ny on 9/24/24.
//

import Foundation

public extension URL {
    var isDirectory: Bool {
        var b: ObjCBool = false
        return FileManager.default.fileExists(atPath: path, isDirectory: &b) && b.boolValue
    }


    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid URL StaticString: \(string)")
        }
        self = url
    }
}
