import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MultiplatformTimebox",
    organizationName: "Grigorii Entin",
    packages: [
        .local(path: "./Modules/MultiplatformTimeboxMacOSApp"),
        .local(path: "./Modules/MultiplatformTimeboxIOSApp")
    ],
    targets: [
        Target(
            name: "macOS-app",
            platform: .macOS,
            product: .app,
            productName: "Timebox_macOS",
            bundleId: "com.grigorye.TimeboxApp",
            infoPlist: "Sources/Info-macOS.plist",
            sources: [
                "Sources/*-macOS.swift"
            ],
            resources: [
                "Modules/MultiplatformTimeboxMacOSApp/Sources/**/Main.storyboard",
                "Shared/SFSymbols.xcassets"
            ],
            entitlements: "Sources/App-macOS.entitlements",
            dependencies: [
                .package(product: "MultiplatformTimeboxMacOSApp")
            ],
            settings: .settings(
                base: [
                    "ENABLE_HARDENED_RUNTIME": "YES"
                ]
                    .automaticCodeSigning(devTeam: "5BV57B67TB")
                    .codeSignIdentityAppleDevelopment()
            )
        ),
        Target(
            name: "iOS-app",
            platform: .iOS,
            product: .app,
            productName: "Timebox_iOS",
            bundleId: "com.grigorye.TimeboxApp",
            infoPlist: "Sources/Info-iOS.plist",
            sources: [
                "Sources/*-iOS.swift"
            ],
            resources: [
                "Shared/SFSymbols.xcassets",
                "Shared/Assets.xcassets"
            ],
            entitlements: "Sources/App-iOS.entitlements",
            dependencies: [
                .package(product: "MultiplatformTimeboxIOSApp")
            ],
            settings: .settings(
                base: [
                    "ENABLE_HARDENED_RUNTIME": "YES"
                ]
                    .automaticCodeSigning(devTeam: "5BV57B67TB")
                    .codeSignIdentityAppleDevelopment()
            )
        )
    ],
    resourceSynthesizers: []
)
