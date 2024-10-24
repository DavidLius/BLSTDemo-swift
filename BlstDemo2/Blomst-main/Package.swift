// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BlstSwift",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "BlstSwift",
            type: .dynamic,
            targets: ["BlstSwift"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/sajjon/BytePattern", from: "0.0.6"),
        .package(url: "https://github.com/attaswift/BigInt", from: "5.3.0"),
    ],
    targets: [
        .binaryTarget(
            name: "BLST",
            path: "BLST.xcframework"
        ),
        .target(
            name: "BlstSwift",
            dependencies: [
                "BLST",
                "BigInt",
                .product(name: "BytesMutation", package: "BytePattern"),
                .product(name: "BytePattern", package: "BytePattern"),
            ]
        ),
        .testTarget(
            name: "BlstSwiftTests",
            dependencies: [
                "BlstSwift",
                .product(name: "XCTAssertBytesEqual", package: "BytePattern"),
            ]
        ),
    ]
)
