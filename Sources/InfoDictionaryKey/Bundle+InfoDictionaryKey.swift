import Foundation

public extension Bundle {
    /// Returns a strongly-typed value for the given Info.plist key or throws a typed error.
    @inlinable
    func value<T>(for key: InfoDictionaryKey<T>) throws(InfoDictionaryError) -> T {
        guard let raw = object(forInfoDictionaryKey: key.name) else {
            throw InfoDictionaryError.missingKey(key: key.name)
        }

        if let typed = raw as? T {
            return typed
        }

        throw InfoDictionaryError.typeMismatch(
            key: key.name,
            expected: String(reflecting: T.self),
            actual: String(reflecting: type(of: raw))
        )
    }

    /// Convenience overload for string values.
    @inlinable
    func string(for key: InfoDictionaryKey<String>) throws(InfoDictionaryError) -> String {
        try value(for: key)
    }

    /// Returns a fallback value when the key is missing or mismatched.
    @inlinable
    func value<T>(for key: InfoDictionaryKey<T>, default defaultValue: @autoclosure () -> T) -> T {
        (try? value(for: key)) ?? defaultValue()
    }
}
