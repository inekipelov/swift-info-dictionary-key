import Foundation

public extension Bundle {
    /// Returns a strongly-typed value for the given Info.plist key or throws a typed error.
    @inlinable
    func value<T: InfoDictionaryKeysValue>(for key: InfoDictionaryKey<T>) throws(InfoDictionaryError) -> T {
        guard let raw = object(forInfoDictionaryKey: key.name) else {
            throw InfoDictionaryError.missingKey(key: key.name)
        }

        if T.self == InfoPlistValue.self, let value = InfoPlistValue(propertyListValue: raw) as? T {
            return value
        }

        if T.self == [String: InfoPlistValue].self, let dictionary = InfoPlistValue.dictionary(propertyListValue: raw) as? T {
            return dictionary
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

    /// Convenience overload for Boolean values.
    @inlinable
    func bool(for key: InfoDictionaryKey<Bool>) throws(InfoDictionaryError) -> Bool {
        try value(for: key)
    }

    /// Convenience overload for string-array values.
    @inlinable
    func array(for key: InfoDictionaryKey<[String]>) throws(InfoDictionaryError) -> [String] {
        try value(for: key)
    }

    /// Convenience overload for dictionary values.
    @inlinable
    func dictionary(for key: InfoDictionaryKey<[String: InfoPlistValue]>) throws(InfoDictionaryError) -> [String: InfoPlistValue] {
        try value(for: key)
    }

    /// Convenience overload for plist values.
    @inlinable
    func plistValue(for key: InfoDictionaryKey<InfoPlistValue>) throws(InfoDictionaryError) -> InfoPlistValue {
        try value(for: key)
    }

    /// Returns a fallback value when the key is missing or mismatched.
    @inlinable
    func value<T: InfoDictionaryKeysValue>(for key: InfoDictionaryKey<T>, default defaultValue: @autoclosure () -> T) -> T {
        (try? value(for: key)) ?? defaultValue()
    }

    /// Returns a fallback Boolean value when the key is missing or mismatched.
    @inlinable
    func bool(for key: InfoDictionaryKey<Bool>, default defaultValue: @autoclosure () -> Bool) -> Bool {
        value(for: key, default: defaultValue())
    }

    /// Returns a fallback string-array value when the key is missing or mismatched.
    @inlinable
    func array(
        for key: InfoDictionaryKey<[String]>,
        default defaultValue: @autoclosure () -> [String]
    ) -> [String] {
        value(for: key, default: defaultValue())
    }

    /// Returns a fallback dictionary value when the key is missing or mismatched.
    @inlinable
    func dictionary(
        for key: InfoDictionaryKey<[String: InfoPlistValue]>,
        default defaultValue: @autoclosure () -> [String: InfoPlistValue]
    ) -> [String: InfoPlistValue] {
        value(for: key, default: defaultValue())
    }

    /// Returns a fallback plist value when the key is missing or mismatched.
    @inlinable
    func plistValue(
        for key: InfoDictionaryKey<InfoPlistValue>,
        default defaultValue: @autoclosure () -> InfoPlistValue
    ) -> InfoPlistValue {
        value(for: key, default: defaultValue())
    }
}
