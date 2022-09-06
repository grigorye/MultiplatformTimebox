// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TimeboxMacOSApp",
    platforms: [.macOS("12")],
    products: [
        .library(
            name: "TimeboxMacOSApp",
            targets: ["TimeboxMacOSApp"]),
    ],
    dependencies: [
        .package(name: "TimeboxApp", path: "../TimeboxApp"),
        .package(name: "TimeboxData", path: "../TimeboxData"),
        .package(name: "TimeboxViews", path: "../TimeboxViews")
    ],
    targets: [
        .target(
            name: "TimeboxMacOSApp",
            dependencies: [
                "TimeboxApp",
                "TimeboxData",
                "TimeboxViews"
            ]
        ),
        .testTarget(
            name: "TimeboxMacOSAppTests",
            dependencies: ["TimeboxMacOSApp"]),
    ]
)
