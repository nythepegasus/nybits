//
//  NB+Bundle.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

#if os(iOS) || os(tvOS) || os(macOS) || os(visionOS) || os(watchOS)

import Foundation

/// An extension for common `Bundle` accesses
public extension Bundle {
    
    enum Keys: String {
        
        // MARK: - Categorization
        
        @available(macOS 10.0, *)
        case appCategoryType = "LSApplicationCategoryType"
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case packageType = "CFBundlePackageType"
        
        // MARK: - Identification
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case identifier = "CFBundleIdentifier"
        
        @available(watchOS 2.0, *)
        case wkidentifier = "WKAppBundleIdentifier"
        
        @available(watchOS 2.0, *)
        case wkCompanionIdentifier = "WKCompanionAppBundleIdentifier"
        
        // MARK: - Naming
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case name = "CFBundleName"
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case displayName = "CFBundleDisplayName"
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case spokenName = "CFBundleSpokenName"
        
        // MARK: - Bundle version
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case version = "CFBundleVersion"
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case shortVersion = "CFBundleShortVersionString"
        
        @available(iOS 2.0, macOS 10.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case infoVersion = "CFBundleInfoDictionaryVersion"
        
        @available(macOS 10.0, *)
        case copyright = "NSHumanReadableCopyright"
        
        // MARK: - Operating System version
        
        @available(macCatalyst 13.0, macOS 10.0, *)
        case minimumMacOSVersion = "LSMinimumSystemVersion"
        
        @available(macCatalyst 13.0, macOS 10.0, *)
        case minimumMacOSVersionByArchitecture = "LSMinimumSystemVersionByArchitecture"
        
        @available(iOS 3.0, tvOS 9.0, visionOS 1.0, *)
        case minimumOSVersion = "MinimumOSVersion"
    
        @available(iOS 12.0, *)
        case requiresiOS = "LSRequiresIPhoneOS"
        
        @available(watchOS 2.0, *)
        case watchKitApp = "WKWatchKitApp"
        
        @available(watchOS 6.0, *)
        case watchKitAppIndependent = "WKRunsIndependentlyOfCompanionApp"
        
        @available(watchOS 6.0, *)
        case watchKitAppOnly = "WKWatchOnly"

        @available(watchOS 2.0, *)
        case watchKitDelegate = "WKExtensionDelegateClassName"
        
        @available(watchOS 7.0, *)
        case newWK = "WKApplication"
        
        @available(iOS 3.0, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case requiredDeviceCapabilities = "UIRequiredDeviceCapabilities"
        
        @available(macOS 10.0, *)
        case multipleInstancesProhibited = "LSMultipleInstancesProhibited"
        
        @available(iOS 4.0, visionOS 1.0, watchOS 4.0, *)
        case backgroundModes = "UIBackgroundModes"
        
        case requiresMacCatalyst = "LSRequiresMacCatalyst"
        
        case requirestvOS = "LSRequiresTVOS"
        
        @available(iOS 2.0, visionOS 1.0, *)
        case requiresPersistentWiFi = "UIRequiresPersistentWiFi"
        
        @available(iOS 3.2, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case supportsFileSharing = "UIFileSharingEnabled"
        
        @available(iOS 12.0, visionOS 1.0, *)
        case supportsDocumentsInPlace = "LSSupportsOpeningDocumentsInPlace"
        
        @available(iOS 11.0, tvOS 11.0, visionOS 1.0, *)
        case supportsDocumentsBrowser = "UISupportsDocumentBrowser"
    }
    
    func object<T>(for key: String) -> T {
        object(forInfoDictionaryKey: key) ??? T.self
    }
    
    func object<T>(for key: Keys) -> T {
        object<T>(for: key.rawValue)
    }
    
    func keyExists(_ key: String) -> Bool {
        object(forInfoDictionaryKey: key) != nil
    }
    
    func keyExists(_ key: Keys) -> Bool {
        keyExists(key.rawValue)
    }
    
    /// The CFBundleName or `""`
    @inlinable
    var bundleName: String { object(for: .name) }
    
    /// The CFBundleShortVersionString or `""`
    @inlinable
    var bundleVersion: String { object(for: .version) }
    
    /// The CFBundleIdentifier or `""`
    @inlinable
    var bundleIdentifier: String { object(for: .identifier) }
    
    /// The MinimumOSVersion or `""`
    @inlinable
    var minimumOSVersion: String { object(for: .minimumOSVersion) }
    
    /// The LSRequiresIPhoneOS or `false`
    @inlinable
    var requiresiOS: Bool { object(for: .requiresiOS) }
    
    /// The UIFileSharingEnabled or `false`
    @inlinable
    var supportsFileSharing: Bool { object(for: .supportsFileSharing) }
    
    /// The UIFileSharingEnabled or `false`
    @inlinable
    var supportsDocumentsInPlace: Bool { object(for: .supportsDocumentsInPlace) }
    
}

#endif
