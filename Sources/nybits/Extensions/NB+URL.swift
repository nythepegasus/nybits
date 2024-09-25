//
//  NB+URL.swift
//  nybits
//
//  Created by ny on 9/24/24.
//

import Foundation

public extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid URL StaticString: \(string)")
        }
        self = url
    }
}

#if !DISABLE_FOUNDATION_DEFAULTABLE
extension URL: Defaultable {
    public static var defaultValue: Self { URL(staticString: "https://nythepegas.us") }
}
#endif
