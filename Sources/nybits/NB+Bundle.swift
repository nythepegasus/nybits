//
//  NB+Bundle.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

extension Bundle {
    @inlinable
    var bundleName: String { object(forInfoDictionaryKey: "CFBundleName") as? String ?? "" }
    @inlinable
    var bundleVersion: String { object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "" }
    @inlinable
    var bundleIdentifier: String { object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? "" }
    @inlinable
    var minimumiOSVersion: String { object(forInfoDictionaryKey: "MinimumOSVersion") as? String ?? "" }
    @inlinable
    var requiresiOS: Bool { object(forInfoDictionaryKey: "LSRequiresIPhoneOS") as? Bool ?? false }
    @inlinable
    var supportsFileSharing: Bool { object(forInfoDictionaryKey: "UIFileSharingEnabled") as? Bool ?? false }
    @inlinable
    var supportsInPlaceDocuments: Bool { object(forInfoDictionaryKey: "UIFileSharingEnabled") as? Bool ?? false }
}
