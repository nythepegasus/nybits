//
//  NB+Bundle.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

/// An extension for common `Bundle` accesses
public extension Bundle {
    /// The CFBundleName or `""`
    @inlinable
    var bundleName: String { object(forInfoDictionaryKey: "CFBundleName") as? String ?? "" }
    
    /// The CFBundleShortVersionString or `""`
    @inlinable
    var bundleVersion: String { object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "" }
    
    /// The CFBundleIdentifier or `""`
    @inlinable
    var bundleIdentifier: String { object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? "" }
    
    /// The MinimumOSVersion or `""`
    @inlinable
    var minimumOSVersion: String { object(forInfoDictionaryKey: "MinimumOSVersion") as? String ?? "" }
    
    /// The LSRequiresIPhoneOS or `false`
    @inlinable
    var requiresiOS: Bool { object(forInfoDictionaryKey: "LSRequiresIPhoneOS") as? Bool ?? false }
    
    /// The UIFileSharingEnabled or `false`
    @inlinable
    var supportsFileSharing: Bool { object(forInfoDictionaryKey: "UIFileSharingEnabled") as? Bool ?? false }
    
    /// The UIFileSharingEnabled or `false`
    @inlinable
    var supportsInPlaceDocuments: Bool { object(forInfoDictionaryKey: "UIFileSharingEnabled") as? Bool ?? false }
}
