// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TimeboxMenuBarApp",
    platforms: [.macOS("10.15")],
    products: [
        .library(
            name: "TimeboxMenuBarApp",
            targets: ["TimeboxMenuBarApp"]),
    ],
    dependencies: [
        .package(name: "TimeboxMacOSApp", path: "../TimeboxMacOSApp"),
        .package(name: "TimeboxApp", path: "../TimeboxApp"),
        .package(name: "TimeboxData", path: "../TimeboxData"),
        .package(name: "TimeboxViews", path: "../TimeboxViews")
    ],
    targets: [
        .target(
            name: "TimeboxMenuBarApp",
            dependencies: [
                "TimeboxMacOSApp",
                "TimeboxApp",
                "TimeboxData",
                "TimeboxViews"
            ]
        ),
        .testTarget(
            name: "TimeboxMenuBarAppTests",
            dependencies: ["TimeboxMenuBarApp"]),
    ]
)
