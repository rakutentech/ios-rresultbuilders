// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RResultBuilders",
    // Minimum platform versions must match the APIs actually used:
    // - Request.swift uses URLSession.data(for:) and TaskGroup APIs → iOS 15
    // - UIKit-only library; iOS/watchOS only (no macOS support)
    // - iOS 15 / watchOS 8
    platforms: [.iOS(.v15), .watchOS(.v8)],
    products: [
        .library(
            name: "RResultBuilders",
            type: .dynamic,
            targets: ["RResultBuilders"]
        ),
        .library(
            name: "RResultBuildersStatic",
            targets: ["RResultBuilders"]
        ),
    ],
    targets: [
        .target(
            name: "RResultBuilders",
            dependencies: []
        ),
        .testTarget(
            name: "RResultBuildersTests",
            dependencies: ["RResultBuilders"]
        ),
    ]
)
