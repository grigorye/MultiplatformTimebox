// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MultiplatformTimeboxIOSApp",
    platforms: [.iOS("13.4")],
    products: [
        .library(
            name: "MultiplatformTimeboxIOSApp",
            targets: ["MultiplatformTimeboxIOSApp"]),
    ],
    dependencies: [
        .package(name: "MultiplatformTimeboxApp", path: "../MultiplatformTimeboxApp"),
        .package(name: "MultiplatformTimeboxData", path: "../MultiplatformTimeboxData"),
        .package(name: "MultiplatformTimeboxViews", path: "../MultiplatformTimeboxViews")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MultiplatformTimeboxIOSApp",
            dependencies: [
                "MultiplatformTimeboxApp",
                "MultiplatformTimeboxData",
                "MultiplatformTimeboxViews"
            ]
        ),
        .testTarget(
            name: "MultiplatformTimeboxIOSAppTests",
            dependencies: ["MultiplatformTimeboxIOSApp"]),
    ]
)
