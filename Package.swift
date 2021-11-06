// swift-tools-version:5.5

import Foundation
import PackageDescription

// MARK: - shared
var package = Package(
    name: "runitz",
    platforms: [
        .iOS(.v15), .tvOS(.v15), .macOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "AppDomain", targets: ["AppDomain"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "Build", targets: ["Build"]),
        .library(name: "DistanceFeature", targets: ["DistanceFeature"]),
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
        .library(name: "PaceFeature", targets: ["PaceFeature"]),
        .library(name: "SettingsFeature", targets: ["SettingsFeature"]),
//        .library(name: "DeviceId", targets: ["DeviceId"]),
//        .library(name: "UserDefaultsClient", targets: ["UserDefaultsClient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
//        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.25.0"),
//        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppDomain",
            dependencies: []
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                "DistanceFeature",
                "HomeFeature",
                "PaceFeature",
                "SettingsFeature"
            ]
        ),
        .target(
            name: "Build",
            dependencies: []
        ),
        .testTarget(
            name: "BuildTests",
            dependencies: [
//                "TestHelpers",
                "Build"
            ]
        ),
        .target(
            name: "DistanceFeature",
            dependencies: []
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                "SettingsFeature"
            ]
        ),
        .target(
            name: "PaceFeature",
            dependencies: []
        ),
        .target(
            name: "SettingsFeature",
            dependencies: []
        ),
    ]
)
