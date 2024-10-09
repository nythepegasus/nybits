//
//  NB+View.swift
//  nybits
//
//  Created by ny on 10/6/24.
//

import nybits
import nybundle
import nydefaults

#if canImport(SwiftUICore) && os(iOS)

import SwiftUICore

public extension View {
    func onChange<T>(_ values: [T], perform: () -> Void) -> some View where T: Equatable {
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
