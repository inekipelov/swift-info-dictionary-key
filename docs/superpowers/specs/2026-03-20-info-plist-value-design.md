# Remove Public `Any` From Info.plist Access

## Summary

The package should keep `Any` only as an internal bridge to Foundation and stop exposing it in the public API. Public dictionary-shaped plist values should become strongly typed through a low-level plist AST named `InfoPlistValue`, while `InfoDictionaryKey<Value>` remains the primary way to predeclare the exact supported type for each key.

## Goals

- Preserve the package’s main purpose: strict typing for Info.plist access.
- Remove public `[String: Any]` and other `Any`-based surface area.
- Keep the API low-level and plist-native rather than decoding directly into domain types.
- Support expressive syntax through literal conformances where it improves ergonomics.

## Public Type Model

Introduce a new public enum:

```swift
public enum InfoPlistValue {
    case string(String)
    case bool(Bool)
    case integer(Int)
    case double(Double)
    case array([InfoPlistValue])
    case dictionary([String: InfoPlistValue])
}
```

The first version intentionally excludes `Data` and `Date` to keep scope focused on the plist shapes already needed by the package. Those cases can be added later if necessary.

### Literal Support

`InfoPlistValue` should conform to:

- `ExpressibleByStringLiteral`
- `ExpressibleByBooleanLiteral`
- `ExpressibleByIntegerLiteral`
- `ExpressibleByFloatLiteral`
- `ExpressibleByArrayLiteral`
- `ExpressibleByDictionaryLiteral`

Dictionary literal support must accept only `String` keys, because plist dictionaries always use strings as keys.

`nil` should not be modeled because property lists do not have a native null value.

## Public API Direction

`InfoDictionaryKey<Value>` remains unchanged and continues to be the main strict contract for predefined keys.

Preferred key declarations:

- `InfoDictionaryKey<String>`
- `InfoDictionaryKey<Bool>`
- `InfoDictionaryKey<[String]>`
- `InfoDictionaryKey<[String: InfoPlistValue]>`

Escape hatch:

- `InfoDictionaryKey<InfoPlistValue>`

This lets the package remain strict by default while still supporting heterogeneous plist values when a caller intentionally chooses that surface.

## Bundle API Changes

Keep the existing generic and convenience APIs:

- `value(for:) throws`
- `value(for:default:)`
- `string(for:)`
- `bool(for:)`
- `array(for:)`

Change dictionary-shaped access:

- Replace public `[String: Any]` dictionary access with `[String: InfoPlistValue]`

Optional additional sugar:

- `plistValue(for key: InfoDictionaryKey<InfoPlistValue>) throws -> InfoPlistValue`
- `plistValue(for key: InfoDictionaryKey<InfoPlistValue>, default: ...) -> InfoPlistValue`

These are optional readability helpers, not required for correctness.

## Internal Bridging

Internally, the package can continue reading raw values through Apple’s `Bundle.object(forInfoDictionaryKey:)`.

Add a private recursive bridge:

- `String` -> `.string`
- `NSNumber` -> `.bool`, `.integer`, or `.double`
- `[Any]` / `NSArray` -> `.array`
- `[String: Any]` / `NSDictionary` -> `.dictionary`

Bridge rules:

- Public API must never return `Any`.
- Unsupported or unexpected runtime shapes should surface as `InfoDictionaryError.typeMismatch`.
- Throwing APIs remain diagnostics-first.
- Defaulted APIs keep current semantics and may still fall back on missing or mismatch.

## Constants Catalog Changes

Dictionary-shaped predefined keys in `InfoDictionaryKey+Define.swift` should change from `[String: Any]` to `[String: InfoPlistValue]`.

The package should continue to predeclare strict key types wherever Apple documentation makes the supported value type clear.

## Testing

Add or update tests to cover:

- `InfoPlistValue` scalar literal initialization
- nested array literal initialization
- nested dictionary literal initialization
- successful bundle reads into `[String: InfoPlistValue]`
- successful bundle reads into `InfoPlistValue`
- recursive conversion of nested dictionary and array plist values
- continued success for existing `String`, `Bool`, and `[String]` APIs
- `missingKey` and `typeMismatch` behavior after the transition

Update README examples to ensure no public-facing sample returns or manipulates `Any`.

## Assumptions

- Public strict typing is more important than preserving the old dictionary API.
- The package should stay low-level and not grow a decoding layer for domain models in this iteration.
- `InfoDictionaryKey<[String: InfoPlistValue]>` should exist because callers may want to predeclare that a specific key must be a dictionary and nothing else.
