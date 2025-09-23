// swift-tools-version: 6.2

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
