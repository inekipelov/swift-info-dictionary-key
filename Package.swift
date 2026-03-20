// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-info-dictionary-key",
    products: [
        .library(
            name: "InfoDictionaryKeys",
            targets: ["InfoDictionaryKeys"]
        )
    ],
    targets: [
        .target(
            name: "InfoDictionaryKeys",
            path: "Sources/InfoDictionaryKey"
        ),
        .testTarget(
            name: "InfoDictionaryKeyTests",
            dependencies: ["InfoDictionaryKeys"],
            resources: [
                .copy("Fixtures/InfoDictionaryFixture.bundle")
            ]
        )
    ]
)
