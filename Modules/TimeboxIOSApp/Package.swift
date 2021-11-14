// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TimeboxIOSApp",
    platforms: [.iOS("13.4")],
    products: [
        .library(
            name: "TimeboxIOSApp",
            targets: ["TimeboxIOSApp"]),
    ],
    dependencies: [
        .package(name: "TimeboxApp", path: "../TimeboxApp"),
        .package(name: "TimeboxData", path: "../TimeboxData"),
        .package(name: "TimeboxViews", path: "../TimeboxViews")
    ],
    targets: [
        .target(
            name: "TimeboxIOSApp",
            dependencies: [
                "TimeboxApp",
                "TimeboxData",
                "TimeboxViews"
            ]
        ),
        .testTarget(
            name: "TimeboxIOSAppTests",
            dependencies: ["TimeboxIOSApp"]),
    ]
)
