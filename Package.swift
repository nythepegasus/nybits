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
        .target(
            name: "nybits",
            swiftSettings: [
                ///.define("DISABLE_FOUNDATION_DEFAULTABLE")
                /// Define this on your own target to disable ny's default `Defaultable` implementations
            ]
        ),
        .executableTarget(name: "nytester", dependencies: ["nybits"]),
        .testTarget(
            name: "nybitsTests",
            dependencies: ["nybits"]
        ),
    ]
)
