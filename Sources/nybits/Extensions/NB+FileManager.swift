//
//  NB+FileManager.swift
//  nybits
//
//  Created by ny on 10/10/24.
//

import Foundation

public protocol AppGroupID {
    var name: String { get }
}

public extension AppGroupID {
    var container: URL? { FileManager.container(self) }
}

public extension AppGroupID where Self: RawRepresentable, Self.RawValue == String {
    var name: String { rawValue }
}

public extension FileManager {
    static func container(_ group: some AppGroupID) -> URL? {
        self.default.container(group)
    }
    
    func container<T: AppGroupID>(_ group: T) -> URL? {
        containerURL(forSecurityApplicationGroupIdentifier: group.name)
    }
}
