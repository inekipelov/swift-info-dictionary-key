import Foundation

/// Errors produced when reading values from a bundle's Info.plist.
public enum InfoDictionaryError: Error, LocalizedError, Sendable, Equatable {
    /// Value is missing in Info.plist.
    case missingKey(key: String)

    /// Value exists but cannot be cast to the expected type.
    case typeMismatch(key: String, expected: String, actual: String)

    public var errorDescription: String? {
        switch self {
        case .missingKey(let key):
            "Missing Info.plist key: \(key)"
        case let .typeMismatch(key, expected, actual):
            "Type mismatch for Info.plist key '\(key)'. Expected \(expected), got \(actual)."
        }
    }
}
