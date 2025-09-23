// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "HackStatUtils",
	platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "HackStatUtils",
            targets: ["HackStatUtils"]
        ),
    ],
    targets: [
        .target(
            name: "HackStatUtils"
        ),

    ]
)
