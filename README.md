# InfoDictionaryKeys

`InfoDictionaryKeys` is a small Swift Package that adds strongly typed accessors
for `Bundle` Info.plist values.

It helps you replace stringly-typed Info.plist reads with a tiny typed API and
typed errors for missing or mismatched values.

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-6.0+-F05138?logo=swift&logoColor=white" alt="Swift 6.0+"></a>
</p>

## Installation

Add the package to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/inekipelov/swift-info-dictionary-key.git", branch: "main")
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

## Usage

```swift
import Foundation
import InfoDictionaryKeys

let appName = try Bundle.main.string(for: .appName)
let bundleIdentifier = try Bundle.main.string(for: .identifier)

let displayName = Bundle.main.value(
    for: InfoDictionaryKey<String>("CFBundleDisplayName"),
    default: "My App"
)

do {
    let buildNumber = try Bundle.main.string(for: .version)
    print(buildNumber)
} catch {
    print(error.localizedDescription)
}
```

## Testing

The repository includes separate GitHub Actions workflows for:

```bash
swift build
swift test
```

## License

Released under the [MIT License](LICENSE).
