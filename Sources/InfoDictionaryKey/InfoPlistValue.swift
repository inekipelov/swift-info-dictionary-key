import Foundation

/// A strongly-typed representation of a property list value.
public enum InfoPlistValue: InfoDictionaryKeysValue, Hashable {
    case string(String)
    case bool(Bool)
    case integer(Int)
    case double(Double)
    case array([InfoPlistValue])
    case dictionary([String: InfoPlistValue])
}

extension InfoPlistValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension InfoPlistValue: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension InfoPlistValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .integer(value)
    }
}

extension InfoPlistValue: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
}

extension InfoPlistValue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: InfoPlistValue...) {
        self = .array(elements)
    }
}

extension InfoPlistValue: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, InfoPlistValue)...) {
        self = .dictionary(.init(uniqueKeysWithValues: elements))
    }
}

extension InfoPlistValue {
    @usableFromInline
    init?(propertyListValue raw: Any) {
        switch raw {
        case let value as String:
            self = .string(value)
        case let value as Bool:
            self = .bool(value)
        case let value as Int:
            self = .integer(value)
        case let value as Double:
            self = .double(value)
        case let value as [Any]:
            let elements = value.compactMap(Self.init(propertyListValue:))
            guard elements.count == value.count else {
                return nil
            }
            self = .array(elements)
        case let value as [String: Any]:
            guard let dictionary = Self.dictionary(propertyListValue: value) else {
                return nil
            }
            self = .dictionary(dictionary)
        case let value as NSNumber:
            if CFGetTypeID(value) == CFBooleanGetTypeID() {
                self = .bool(value.boolValue)
            } else if value.isIntegral {
                self = .integer(value.intValue)
            } else {
                self = .double(value.doubleValue)
            }
        default:
            return nil
        }
    }

    @usableFromInline
    static func dictionary(propertyListValue raw: Any) -> [String: InfoPlistValue]? {
        guard let dictionary = raw as? [String: Any] else {
            return nil
        }

        var typed: [String: InfoPlistValue] = [:]
        typed.reserveCapacity(dictionary.count)

        for (key, value) in dictionary {
            guard let plistValue = Self(propertyListValue: value) else {
                return nil
            }
            typed[key] = plistValue
        }

        return typed
    }
}

extension NSNumber {
    @usableFromInline
    var isIntegral: Bool {
        let double = doubleValue
        let rounded = double.rounded(.towardZero)
        return rounded == double && double >= Double(Int.min) && double <= Double(Int.max)
    }
}
