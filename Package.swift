// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "BackgroundServiceKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BackgroundServiceKit",
            targets: ["BackgroundServiceKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BackgroundServiceKit",
            dependencies: []
        ),
        .testTarget(
            name: "BackgroundServiceKitTests",
            dependencies: ["BackgroundServiceKit"]
        ),
    ]
)
