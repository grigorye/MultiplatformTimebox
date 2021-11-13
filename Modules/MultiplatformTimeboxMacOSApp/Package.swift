// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MultiplatformTimeboxMacOSApp",
    platforms: [.macOS("10.15")],
    products: [
        .library(
            name: "MultiplatformTimeboxMacOSApp",
            targets: ["MultiplatformTimeboxMacOSApp"]),
    ],
    dependencies: [
        .package(name: "MultiplatformTimeboxApp", path: "../MultiplatformTimeboxApp"),
        .package(name: "MultiplatformTimeboxData", path: "../MultiplatformTimeboxData"),
        .package(name: "MultiplatformTimeboxViews", path: "../MultiplatformTimeboxViews")
    ],
    targets: [
        .target(
            name: "MultiplatformTimeboxMacOSApp",
            dependencies: [
                "MultiplatformTimeboxApp",
                "MultiplatformTimeboxData",
                "MultiplatformTimeboxViews"
            ]
        ),
        .testTarget(
            name: "MultiplatformTimeboxMacOSAppTests",
            dependencies: ["MultiplatformTimeboxMacOSApp"]),
    ]
)
