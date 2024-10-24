//
//  NB+View.swift
//  nybits
//
//  Created by ny on 10/6/24.
//

import nybits
import nybundle
import nydefaults

#if canImport(SwiftUI) && os(iOS)

import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension View {
    func onChange<T>(_ values: [T], perform: @autoclosure () -> Void) -> some View where T: Equatable {
        var previousValues: [T] = values

        if values != previousValues {
            previousValues = values
            perform()
        }
        return self
    }
    
    func onChange<T>(_ values: [T], perform: ([T]) -> Void) -> some View where T: Equatable {
        var previousValues: [T] = values

        if values != previousValues {
            previousValues = values
            perform(previousValues)
        }
        return self
    }
}

#endif
