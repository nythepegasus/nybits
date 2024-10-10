//
//  NB+FileManager.swift
//  nybits
//
//  Created by ny on 10/10/24.
//

#if os(iOS)

import Foundation

public protocol AppGroupID {
    var identifier: String { get }
}

public extension FileManager {
    enum NYAppGroup: String, CaseIterable, AppGroupID {
        case ny = "group.ny.apps"
        
        public var identifier: String { rawValue }
    }
    
    static func container(_ group: some AppGroupID) -> URL? {
        self.default.container(group)
    }
    
    func container(_ group: some AppGroupID) -> URL? {
        containerURL(forSecurityApplicationGroupIdentifier: group.identifier)
    }
}

#endif
