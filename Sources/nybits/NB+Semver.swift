//
//  NB+Semver.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

#if canImport(Semver)

import Semver

public extension Semver {
    func nextPatch(_ versions: Int = 1) -> Semver { Semver(major: self.major, minor: self.minor, patch: self.patch + versions) }
    var nextPatch: Semver {nextPatch() }
    
    func nextMinor(_ versions: Int = 1) -> Semver { Semver(major: self.major, minor: self.minor + versions, patch: 0) }
    var nextMinor: Semver { nextMinor() }
    
    func nextMajor(_ versions: Int = 1) -> Semver { Semver(major: self.major + versions, minor: 0, patch: 0) }
    var nextMajor: Semver { nextMajor() }
    
    static var buh: Semver {
        Semver(major: 0, minor: 0, patch: 1, prerelease: ["0"], buildMetadata: ["Buh"])
    }
}

#endif
