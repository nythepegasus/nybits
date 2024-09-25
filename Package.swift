// swift-tools-version: 5.9

import PackageDescription

let nydependencies: [Target.Dependency] = [
    "nybits",
    "nydefaults"
]

let package = Package(
    name: "nybits",
    products: [
        .library(name: "nybits", targets: ["nybits"]),
        .library(name: "nydefaults", targets: ["nybits", "nydefaults"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", branch: "main"),
    ],
    targets: [
        .target(name: "nybits"),
        .target(name: "nydefaults", dependencies: ["nybits"]),
        .executableTarget(name: "nytester", dependencies: nydependencies),
        .testTarget(name: "nybitsTests", dependencies: nydependencies),
    ]
)
