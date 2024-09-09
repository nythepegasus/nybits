//
//  NB+Semver.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

#if canImport(Semver)

// MARK: - Semver Extensions

public extension Semver {
    
    /// Returns the next patch version by incrementing the patch component of the semantic version.
    ///
    /// This function allows you to increment the patch version by a specified number. The default increment is 1.
    ///
    /// - Parameter versions: The number of patch versions to increment. Defaults to `1`.
    /// - Returns: A new `Semver` object with the incremented patch version.
    func nextPatch(_ versions: Int = 1) -> Semver {
        Semver(major: self.major, minor: self.minor, patch: self.patch + versions)
    }
    
    /// A computed property that returns the next patch version with a default increment of `1`.
    ///
    /// Equivalent to calling `nextPatch()` with no arguments.
    ///
    /// - Returns: A new `Semver` object with the incremented patch version.
    var nextPatch: Semver { nextPatch() }
    
    /// Returns the next minor version by incrementing the minor component of the semantic version and resetting the patch version to `0`.
    ///
    /// This function allows you to increment the minor version by a specified number. The default increment is 1.
    ///
    /// - Parameter versions: The number of minor versions to increment. Defaults to `1`.
    /// - Returns: A new `Semver` object with the incremented minor version and the patch version reset to `0`.
    func nextMinor(_ versions: Int = 1) -> Semver {
        Semver(major: self.major, minor: self.minor + versions, patch: 0)
    }
    
    /// A computed property that returns the next minor version with a default increment of `1`, resetting the patch version to `0`.
    ///
    /// Equivalent to calling `nextMinor()` with no arguments.
    ///
    /// - Returns: A new `Semver` object with the incremented minor version and the patch version reset to `0`.
    var nextMinor: Semver { nextMinor() }
    
    /// Returns the next major version by incrementing the major component of the semantic version and resetting the minor and patch versions to `0`.
    ///
    /// This function allows you to increment the major version by a specified number. The default increment is 1.
    ///
    /// - Parameter versions: The number of major versions to increment. Defaults to `1`.
    /// - Returns: A new `Semver` object with the incremented major version and both the minor and patch versions reset to `0`.
    func nextMajor(_ versions: Int = 1) -> Semver {
        Semver(major: self.major + versions, minor: 0, patch: 0)
    }
    
    /// A computed property that returns the next major version with a default increment of `1`, resetting the minor and patch versions to `0`.
    ///
    /// Equivalent to calling `nextMajor()` with no arguments.
    ///
    /// - Returns: A new `Semver` object with the incremented major version and both the minor and patch versions reset to `0`.
    var nextMajor: Semver { nextMajor() }
    
    /// A static `Semver` object representing a predefined semantic version `0.0.1` with a prerelease tag `0` and build metadata `Buh`.
    ///
    /// This static property serves as an example or a predefined version.
    ///
    /// - Returns: A `Semver` object with the following properties:
    ///   - Major: `0`
    ///   - Minor: `0`
    ///   - Patch: `1`
    ///   - Prerelease: `["0"]`
    ///   - Build Metadata: `["Buh"]`
    static var buh: Semver {
        Semver(major: 0, minor: 0, patch: 1, prerelease: ["0"], buildMetadata: ["Buh"])
    }
}

#endif
