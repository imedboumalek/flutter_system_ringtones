// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_system_ringtones",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "flutter-system-ringtones", targets: ["flutter_system_ringtones"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "flutter_system_ringtones",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            path: "Sources/flutter_system_ringtones"
        )
    ]
)
