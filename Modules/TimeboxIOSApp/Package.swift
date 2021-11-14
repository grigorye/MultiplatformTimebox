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
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
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
