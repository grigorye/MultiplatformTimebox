import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Timebox",
    organizationName: "Grigorii Entin",
    packages: [
        .local(path: "./Modules/TimeboxMacOSApp"),
        .local(path: "./Modules/TimeboxIOSApp")
    ],
    targets: [
        Target(
            name: "macOS-app",
            platform: .macOS,
            product: .app,
            productName: "Timebox_macOS",
            bundleId: "com.gentin.TimeboxApp",
            infoPlist: "Sources/Info-macOS.plist",
            sources: [
                "Sources/*-macOS.swift"
            ],
            resources: [
                "Sources/Generated/*.xcassets",
                "Modules/TimeboxMacOSApp/Sources/**/Main.storyboard",
                "Shared/SFSymbols.xcassets",
            ],
            entitlements: "Sources/App-macOS.entitlements",
            dependencies: [
                .package(product: "TimeboxMacOSApp")
            ],
            settings: .settings(
                base: [
                    "ENABLE_HARDENED_RUNTIME": "YES"
                ]
                    .automaticCodeSigning(devTeam: "465NA5BW7E")
                    .codeSignIdentityAppleDevelopment()
            )
        ),
        Target(
            name: "iOS-app",
            platform: .iOS,
            product: .app,
            productName: "Timebox_iOS",
            bundleId: "com.gentin.TimeboxApp",
            infoPlist: "Sources/Info-iOS.plist",
            sources: [
                "Sources/*-iOS.swift"
            ],
            resources: [
                "Sources/Generated/*.xcassets",
                "Shared/SFSymbols.xcassets",
                "Shared/Assets.xcassets",
            ],
            entitlements: "Sources/App-iOS.entitlements",
            dependencies: [
                .package(product: "TimeboxIOSApp")
            ],
            settings: .settings(
                base: [
                    "ENABLE_HARDENED_RUNTIME": "YES"
                ]
                    .automaticCodeSigning(devTeam: "465NA5BW7E")
                    .codeSignIdentityAppleDevelopment()
            )
        )
    ],
    resourceSynthesizers: []
)
