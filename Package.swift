// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Polyline",
    platforms: [
      .macOS(.v10_12), .iOS(.v10), .tvOS(.v10)
    ],
    products: [
        .library(
            name: "Polyline",
            targets: ["Polyline"]),
    ],
    targets: [
        .target(
            name: "Polyline",
            dependencies: []),
        .testTarget(
            name: "PolylineTests",
            dependencies: ["Polyline"]),
    ],
    swiftLanguageVersions: [.v5]
)
