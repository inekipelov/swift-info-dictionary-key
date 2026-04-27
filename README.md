# InfoDictionaryKeys

`InfoDictionaryKeys` is a small Swift Package that adds strongly typed accessors
for `Bundle` Info.plist values.

It helps you replace stringly-typed Info.plist reads with a tiny typed API and
typed errors for missing or mismatched values.

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-6.0+-F05138?logo=swift&logoColor=white" alt="Swift 6.0+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/iOS-13.0+-CAFC63?logo=apple" alt="iOS 13.0+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/macOS-10.15+-CAFC63?logo=apple" alt="macOS 10.15+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/tvOS-13.0+-CAFC63?logo=apple" alt="tvOS 13.0+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/watchOS-6.0+-CAFC63?logo=apple" alt="watchOS 6.0+"></a>
  <a href="https://developer.apple.com/visionos/"><img src="https://img.shields.io/badge/visionOS-1.0+-CAFC63?logo=apple" alt="visionOS 1.0+"></a>
</p>

## Usage

```swift
import Foundation
import InfoDictionaryKeys

let appName = try Bundle.main.string(for: .appName)
let bundleIdentifier = try Bundle.main.string(for: .identifier)
let interfaceStyle = try Bundle.main.value(for: .userInterfaceStyle)
let displayName = Bundle.main.value(for: "CFBundleDisplayName", default: "My App")
let requiresIPhoneOS = Bundle.main.value(for: "LSRequiresIPhoneOS", default: false)
let temporaryLocationReason = try Bundle.main.dictionary(for: .locationTemporaryUsageDescriptionDictionary)
let rawValue = try Bundle.main.plistValue(for: "NSLocationTemporaryUsageDescriptionDictionary")
```

## Installation

Add the package to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/inekipelov/swift-info-dictionary-key.git", from: "0.1.0")
```

Then add `InfoDictionaryKeys` to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        "InfoDictionaryKeys"
    ]
)
```
