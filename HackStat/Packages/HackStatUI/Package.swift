// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "HackStatUI",
	platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "HackStatUI",
            targets: ["HackStatUI"]
        ),
    ],
	dependencies: [
		.package(path: "../HackStatModels/"),
		.package(path: "../HackStatCore/"),
	],
    targets: [
        .target(
            name: "HackStatUI",
			dependencies: [
				.product(name: "HackStatModels", package: "HackStatModels"),
				.product(name: "HackStatCore", package: "HackStatCore"),
			]
        ),

    ]
)
