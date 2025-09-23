// swift-tools-version: 6.2

import PackageDescription

let package = Package(
	name: "HackStatCore",
	platforms: [.iOS(.v18)],
	products: [
		.library(
			name: "HackStatCore",
			targets: ["HackStatCore"]
		)
	],
	dependencies: [
		.package(path: "../HackStatModels/"),
		.package(path: "../HackStatUtils/"),
	],
	targets: [
		.target(
			name: "HackStatCore",
			dependencies: [
				.product(name: "HackStatUtils", package: "HackStatUtils"),
				.product(name: "HackStatModels", package: "HackStatModels"),
			]
		),
		.testTarget(
			name: "HackStatCoreTests",
			dependencies: [
				"HackStatCore"
			]
		),
	]
)
