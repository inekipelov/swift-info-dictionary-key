import Foundation

/// Marker protocol for plist-safe value types supported by ``InfoDictionaryKey``.
public protocol InfoDictionaryKeysValue: Sendable {}

extension String: InfoDictionaryKeysValue {}
extension Bool: InfoDictionaryKeysValue {}
extension Int: InfoDictionaryKeysValue {}
extension Double: InfoDictionaryKeysValue {}
extension Array: InfoDictionaryKeysValue where Element == String {}
extension Dictionary: InfoDictionaryKeysValue where Key == String, Value == InfoPlistValue {}
