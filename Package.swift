// swift-tools-version: 5.9

import PackageDescription

let baseDep: [Target.Dependency] = ["nybits"]
let bundleDep: [Target.Dependency] = baseDep + ["nydefaults"]
let suiDep: [Target.Dependency] = baseDep + ["nybundle"]
let allDep: [Target.Dependency] = suiDep + ["nysuibits"]

#if true
let nybits: Target = .target(name: "nybits")
let nydefaults: Target = .target(name: "nydefaults", dependencies: baseDep)
let nybundle: Target = .target(name: "nybundle", dependencies: bundleDep)
let nysuibits: Target = .target(name: "nysuibits", dependencies: suiDep)
let nytester: Target = .executableTarget(name: "nytester", dependencies: allDep)
#else
let unsafeSettings: [SwiftSetting] = [.define("ENABLE_UNSAFE_DEFAULTABLE_OPTIONAL")]

let nybits: Target = .target(name: "nybits", swiftSettings: unsafeSettings)
let nydefaults: Target = .target(name: "nydefaults", dependencies: baseDep, swiftSettings: unsafeSettings)
let nybundle: Target = .target(name: "nybundle", dependencies: bundleDep, swiftSettings: unsafeSettings)
let nysuibits: Target = .target(name: "nysuibits", dependencies: suiDep, swiftSettings: unsafeSettings)
let nytester: Target = .executableTarget(name: "nytester", dependencies: allDep, swiftSettings: unsafeSettings)
#endif

let nytests: Target = .testTarget(name: "nytests", dependencies: allDep)

let base: [Target] = [nybits, nydefaults]
let bundle: [Target] = base + [nybundle]
let all: [Target] = bundle + [nytester, nysuibits, nytests]

let products: [Product] = [
    .library(name: "nybits", targets: ["nybits"]),
    .library(name: "nydefaults", targets: base.map(\.name)),
    .library(name: "nybundle", targets: bundle.map(\.name)),
    .library(name: "nysuibits", targets: bundle.map(\.name)),
    .executable(name: "nytester", targets: ["nytester"])
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-docc-plugin", branch: "main"),
]

let package = Package(name: "nybits", products: products, dependencies: dependencies, targets: all)
