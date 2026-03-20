import Foundation

/// Strongly-typed key for values stored in Info.plist.
public struct InfoDictionaryKey<Value>: Hashable, Sendable {
    /// Underlying plist key string.
    public let name: String

    /// Creates a typed Info.plist key from its raw string name.
    public init(_ name: String) {
        self.name = name
    }
}

extension InfoDictionaryKey: ExpressibleByUnicodeScalarLiteral where Value == String {
    public init(unicodeScalarLiteral value: String) {
        self.name = value
    }
}

extension InfoDictionaryKey: ExpressibleByExtendedGraphemeClusterLiteral where Value == String {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.name = value
    }
}

extension InfoDictionaryKey: ExpressibleByStringLiteral where Value == String {
    public init(stringLiteral value: String) {
        self.name = value
    }
}
