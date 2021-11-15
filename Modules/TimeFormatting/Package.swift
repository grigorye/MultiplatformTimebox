// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TimeFormatting",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TimeFormatting",
            targets: ["TimeFormatting"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TimeFormatting",
            dependencies: []),
        .testTarget(
            name: "TimeFormattingTests",
            dependencies: ["TimeFormatting"]),
    ]
)
