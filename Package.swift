// swift-tools-version: 5.9

import PackageDescription

let nydependencies: [Target.Dependency] = ["nybits", "nydefaults"]

#if true
let nybits: Target = .target(name: "nybits")
let nydefaults: Target = .target(name: "nydefaults", dependencies: ["nybits"])
let nybundle: Target = .target(name: "nybundle", dependencies: nydependencies)
let nytester: Target = .executableTarget(name: "nytester", dependencies: nydependencies)
#else
let unsafeSettings: [SwiftSetting] = [.define("ENABLE_UNSAFE_DEFAULTABLE_OPTIONAL")]

let nybits: Target = .target(name: "nybits", swiftSettings: unsafeSettings)
let nydefaults: Target = .target(name: "nydefaults", dependencies: ["nybits"], swiftSettings: unsafeSettings)
let nybundle: Target = .target(name: "nybundle", dependencies: nydependencies, swiftSettings: unsafeSettings)
let nytester: Target = .executableTarget(name: "nytester", dependencies: nydependencies, swiftSettings: unsafeSettings)
#endif

let nytests: Target = .testTarget(name: "nybitsTests", dependencies: nydependencies)

let targets: [Target] = [nybits, nydefaults, nytester, nybundle, nytests]

let products: [Product] = [
    .library(name: "nybits", targets: ["nybits"]),
    .library(name: "nydefaults", targets: ["nybits", "nydefaults"]),
    .library(name: "nybundle", targets: ["nybits", "nydefaults", "nybundle"]),
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-docc-plugin", branch: "main"),
]

let package = Package(name: "nybits", products: products, dependencies: dependencies, targets: targets)
