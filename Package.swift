// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "NiftyInject",
    platforms: [
      .iOS(.v11),
      .macOS(.v10_13),
      .tvOS(.v11),
      .watchOS(.v4),
    ],
    products: [
        .library(
            name: "NiftyInject",
            targets: ["NiftyInject"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        .target(
            name: "NiftyInject",
            dependencies: [
              .product(name: "Swinject", package: "Swinject")
            ]),
        .testTarget(
            name: "NiftyInjectTests",
            dependencies: ["NiftyInject"]),
    ]
)
