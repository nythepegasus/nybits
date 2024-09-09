// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "nybits",
    products: [
        .library(name: "nybits", targets: ["nybits"]),
        .executable(name: "nytester", targets: ["nytester"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", branch: "main"),
    ],
    targets: [
        .target(name: "nybits"),
        .executableTarget(name: "nytester", dependencies: ["nybits"]),
        .testTarget(
            name: "nybitsTests",
            dependencies: ["nybits"]
        ),
    ]
)
