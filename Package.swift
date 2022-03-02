// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "vagemcast",

    platforms: [
        .iOS(.v15),
        .macOS(.v11),
        .tvOS(.v15),
        .watchOS(.v7),
    ],

    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.30.0"),
        .package(url: "https://github.com/pointfreeco/swift-overture", from: "0.5.0"),
//        .package(name: "Overture", url: "https://github.com/pointfreeco/swift-overture", from: "0.5.0"),
        .package(url: "https://github.com/pointfreeco/swiftui-navigation", from: "0.1.0"),
    ],

    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: [
                "AppFeature"
            ]
        ),
    ]
)
