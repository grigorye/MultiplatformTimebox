// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TimeboxApp",
    platforms: [
        .macOS(.v10_15),
        .iOS("13.4"),
    ],
    products: [
        .library(
            name: "TimeboxApp",
            targets: ["TimeboxApp"]),
    ],
    dependencies: [
        .package(name: "TimeboxData", path: "../TimeboxData"),
        .package(name: "TimeboxViews", path: "../TimeboxViews"),
    ],
    targets: [
        .target(
            name: "TimeboxApp",
            dependencies: [
                "TimeboxData",
                "TimeboxViews",
            ]),
        .testTarget(
            name: "TimeboxAppTests",
            dependencies: [
                "TimeboxApp"
            ]),
    ]
)
