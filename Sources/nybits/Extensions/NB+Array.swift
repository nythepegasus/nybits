//
//  NB+Array.swift
//  nybits
//
//  Created by ny on 9/24/24.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    func mapValues<T>(_ transform: (Element) -> T) -> [T] {
        map { transform($0) }
    }
}

public extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var seen: Set<Element> = []
        return filter { seen.insert($0).inserted }
    }
}

public extension Sequence {
    func randomElement() -> Element? {
        Array(enumerated().lazy.map(\.element)).randomElement()
    }
}
