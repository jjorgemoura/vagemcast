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
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
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
