# SwiftLintPlugin

This is a SwiftPM plugin that adds a lint command. SwiftPM plugins are only available in Swift 5.6+

## Usage

Add the following dependency to your `Package.swift` file:

```swift
.package(name: "SwiftLintPlugin", url: "https://github.com/stackotter/swift-lint-plugin", branch: "main")
```

And then lint your project with:

```swift
swift package plugin --disable-sandbox lint
```

Or if you want to lint a specific target:

```swift
swift package plugin --target MyTarget --disable-sandbox lint
```
