// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "URLImage",
	platforms: [.iOS(.v13)],
	products: [
		.library(
			name: "URLImage",
			targets: ["URLImage"]),
	],
	dependencies: [],
	targets: [
		.target(
			name: "URLImage",
			dependencies: []),
		.testTarget(
			name: "URLImageTests",
			dependencies: ["URLImage"]),
	]
)
