// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FormatKit",
    products: [
        .library(
            name: "FormatKit",
            targets: ["FormatKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FormatKit",
            dependencies: []),
        .testTarget(
            name: "FormatKitTests",
            dependencies: ["FormatKit"]),
    ]
)
