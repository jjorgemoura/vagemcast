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
        ),
        .library(
            name: "PlayerFeature",
            targets: ["PlayerFeature"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.38.0"),
        //        .package(url: "https://github.com/pointfreeco/swift-overture", from: "0.5.0"),
        //        .package(name: "Overture", url: "https://github.com/pointfreeco/swift-overture", from: "0.5.0"),
            .package(url: "https://github.com/pointfreeco/swiftui-navigation", from: "0.1.0"),

        //        .package(url: "https://github.com/jjorgemoura/alfaz", branch: "main"),
        //        .package(url: "https://github.com/jjorgemoura/beatz", branch: "main"),
        //        .package(url: "https://github.com/jjorgemoura/defectz", branch: "main"),
        //        .package(url: "https://github.com/jjorgemoura/gavetaz", branch: "main"),
        //        .package(url: "https://github.com/jjorgemoura/variationz", branch: "main"),
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
        .target(
            name: "PlayerFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "PlayerFeatureTests",
            dependencies: [
                "AppFeature"
            ]
        ),
    ]
)
