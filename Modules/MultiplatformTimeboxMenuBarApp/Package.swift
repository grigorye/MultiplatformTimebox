// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MultiplatformTimeboxMenuBarApp",
    platforms: [.macOS("10.15")],
    products: [
        .library(
            name: "MultiplatformTimeboxMenuBarApp",
            targets: ["MultiplatformTimeboxMenuBarApp"]),
    ],
    dependencies: [
        .package(name: "MultiplatformTimeboxMacOSApp", path: "../MultiplatformTimeboxMacOSApp"),
        .package(name: "MultiplatformTimeboxApp", path: "../MultiplatformTimeboxApp"),
        .package(name: "MultiplatformTimeboxData", path: "../MultiplatformTimeboxData"),
        .package(name: "MultiplatformTimeboxViews", path: "../MultiplatformTimeboxViews")
    ],
    targets: [
        .target(
            name: "MultiplatformTimeboxMenuBarApp",
            dependencies: [
                "MultiplatformTimeboxMacOSApp",
                "MultiplatformTimeboxApp",
                "MultiplatformTimeboxData",
                "MultiplatformTimeboxViews"
            ]
        ),
        .testTarget(
            name: "MultiplatformTimeboxMenuBarAppTests",
            dependencies: ["MultiplatformTimeboxMenuBarApp"]),
    ]
)
