// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "HackStatNetworkUtils",
	platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "HackStatNetworkUtils",
            targets: ["HackStatNetworkUtils"]
        ),
    ],
    targets: [
        .target(
            name: "HackStatNetworkUtils"
        ),

    ]
)
