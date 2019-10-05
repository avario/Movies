// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChainKit",
	platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChainKit",
            targets: ["ChainKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ChainKit",
            dependencies: []),
        .testTarget(
            name: "ChainKitTests",
            dependencies: ["ChainKit"]),
    ]
)
