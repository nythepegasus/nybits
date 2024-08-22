// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "nybits",
    products: [
        .library(name: "nybits", targets: ["nybits"]),
    ],
    targets: [
        .target(name: "nybits"),
        .testTarget(
            name: "nybitsTests",
            dependencies: ["nybits"]
        ),
    ]
)
