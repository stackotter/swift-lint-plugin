// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SwiftLintPlugin",
    platforms: [.macOS(.v10_12)],
    products: [
//        .plugin(name: "SwiftLintPlugin", targets: ["SwiftLintPlugin"]),
        .plugin(name: "LintCommand", targets: ["LintCommand"])
    ],
    dependencies: [
        .package(url: "https://github.com/stackotter/SwiftLint", from: "0.46.2")
    ],
    targets: [
//        .plugin(
//            name: "SwiftLintPlugin",
//            capability: .buildTool(),
//            dependencies: [.product(name: "swiftlint", package: "SwiftLint")]
//        ),
        .plugin(
            name: "LintCommand",
            capability: .command(intent: .custom(
                verb: "lint",
                description: "Runs swiftlint on all targets"
            )),
            dependencies: [.product(name: "swiftlint", package: "SwiftLint")]
        )
    ]
)
