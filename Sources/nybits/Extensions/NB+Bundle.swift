//
//  NB+Bundle.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

#if os(iOS) || os(tvOS) || os(macOS) && !DISABLE_FOUNDATION_DEFAULTABLE

import Foundation

/// An extension for common `Bundle` accesses
public extension Bundle {
    /// The CFBundleName or `""`
    @inlinable
    var bundleName: String { object(forInfoDictionaryKey: "CFBundleName") ??? "" }
    
    var abundleName: String { object(forInfoDictionaryKey: "CFBundleName") as? String ?? "" }

    var test: Date { object(forInfoDictionaryKey: "test") ??? Date() }
    
    var dtest: Date { object(forInfoDictionaryKey: "test") as? Date ?? Date() }

    /// The CFBundleShortVersionString or `""`
    @inlinable
    var bundleVersion: String { object(forInfoDictionaryKey: "CFBundleShortVersionString") ??? "" }
    
    /// The CFBundleIdentifier or `""`
    @inlinable
    var bundleIdentifier: String { object(forInfoDictionaryKey: "CFBundleIdentifier") ??? "" }
    
    /// The MinimumOSVersion or `""`
    @inlinable
    var minimumOSVersion: String { object(forInfoDictionaryKey: "MinimumOSVersion") ??? "" }
    
    /// The LSRequiresIPhoneOS or `false`
    @inlinable
    var requiresiOS: Bool { object(forInfoDictionaryKey: "LSRequiresIPhoneOS") ??? false }
    
    /// The UIFileSharingEnabled or `false`
    @inlinable
    var supportsFileSharing: Bool { object(forInfoDictionaryKey: "UIFileSharingEnabled") ??? false }
    
    /// The UIFileSharingEnabled or `false`
    @inlinable
    var supportsInPlaceDocuments: Bool { object(forInfoDictionaryKey: "UIFileSharingEnabled") ??? false }
}

#endif
