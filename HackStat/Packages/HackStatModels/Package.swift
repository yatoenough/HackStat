// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HackStatModels",
	platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "HackStatModels",
            targets: ["HackStatModels"]
        ),
    ],
    targets: [
        .target(
            name: "HackStatModels"
        ),

    ]
)
