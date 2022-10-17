// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TimeboxViews",
    platforms: [
        .macOS(.v11),
        .iOS("13.4"),
    ],
    products: [
        .library(
            name: "TimeboxViews",
            targets: ["TimeboxViews"]),
    ],
    dependencies: [
        .package(name: "Introspect", url: "https://github.com/timbersoftware/SwiftUI-Introspect", from: "0.1.0"),
        .package(name: "TimeboxData", path: "../TimeboxData"),
        .package(name: "TimeFormatting", path: "../TimeFormatting"),
    ],
    targets: [
        .target(
            name: "TimeboxViews",
            dependencies: [
                .product(name: "Introspect", package: "Introspect", condition: .when(platforms: [.macOS])),
                "TimeboxData",
                "TimeFormatting",
            ]),
        .testTarget(
            name: "TimeboxViewsTests",
            dependencies: ["TimeboxViews"]),
    ]
)
