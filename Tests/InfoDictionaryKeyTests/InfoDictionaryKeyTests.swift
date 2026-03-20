import Foundation
import Testing
@testable import InfoDictionaryKeys

@Suite("InfoDictionaryKey")
struct InfoDictionaryKeyTests {
    @Test("InfoPlistValue supports scalar and collection literals")
    func infoPlistValueSupportsLiterals() {
        let stringValue: InfoPlistValue = "hello"
        let boolValue: InfoPlistValue = true
        let integerValue: InfoPlistValue = 3
        let doubleValue: InfoPlistValue = 3.5
        let arrayValue: InfoPlistValue = ["alpha", true, 1]
        let dictionaryValue: InfoPlistValue = ["name": "demo", "enabled": true, "count": 2]

        #expect(stringValue == .string("hello"))
        #expect(boolValue == .bool(true))
        #expect(integerValue == .integer(3))
        #expect(doubleValue == .double(3.5))
        #expect(arrayValue == .array([.string("alpha"), .bool(true), .integer(1)]))
        #expect(
            dictionaryValue == .dictionary([
                "name": .string("demo"),
                "enabled": .bool(true),
                "count": .integer(2),
            ])
        )
    }

    @Test("Reads a known string key from a fixture bundle")
    func readsKnownStringValue() throws {
        let bundle = try #require(fixtureBundle())

        let value = try bundle.string(for: .appName)

        #expect(value == "FixtureBundle")
    }

    @Test("Reads a known non-string value from a fixture bundle")
    func readsKnownTypedValue() throws {
        let bundle = try #require(fixtureBundle())

        let key: InfoDictionaryKey<Bool> = "FixtureBoolean"
        let value = try bundle.bool(for: key)

        #expect(value == true)
    }

    @Test("Reads a string array from a fixture bundle")
    func readsKnownArrayValue() throws {
        let bundle = try #require(fixtureBundle())

        let key: InfoDictionaryKey<[String]> = "FixtureStringArray"
        let value = try bundle.array(for: key)

        #expect(value == ["alpha", "beta"])
    }

    @Test("Reads a dictionary from a fixture bundle")
    func readsKnownDictionaryValue() throws {
        let bundle = try #require(fixtureBundle())

        let key: InfoDictionaryKey<[String: InfoPlistValue]> = "FixtureDictionary"
        let value = try bundle.dictionary(for: key)

        #expect(value["first"] == .string("one"))
        #expect(value["second"] == .string("two"))
        #expect(value["flag"] == .bool(true))
        #expect(
            value["nested"] == .dictionary([
                "count": .integer(7),
                "ratio": .double(1.5),
            ])
        )
    }

    @Test("Reads a heterogeneous plist value from a fixture bundle")
    func readsKnownPlistValue() throws {
        let bundle = try #require(fixtureBundle())

        let key: InfoDictionaryKey<InfoPlistValue> = "FixtureValueTree"
        let value = try bundle.plistValue(for: key)

        #expect(
            value == .dictionary([
                "enabled": .bool(true),
                "items": .array([.string("alpha"), .integer(2)]),
                "title": .string("demo"),
            ])
        )
    }

    @Test("Throws missingKey when a key is absent")
    func throwsMissingKey() throws {
        let bundle = try #require(fixtureBundle())
        let key = InfoDictionaryKey<String>("MissingKey")

        #expect(throws: InfoDictionaryError.self) {
            try bundle.value(for: key)
        }

        do {
            _ = try bundle.value(for: key) as String
            Issue.record("Expected missingKey error")
        } catch let error {
            #expect(error == .missingKey(key: "MissingKey"))
        }
    }

    @Test("Throws typeMismatch when a key cannot be cast to the requested type")
    func throwsTypeMismatch() throws {
        let bundle = try #require(fixtureBundle())
        let key = InfoDictionaryKey<String>("FixtureBoolean")

        #expect(throws: InfoDictionaryError.self) {
            try bundle.value(for: key)
        }

        do {
            _ = try bundle.value(for: key) as String
            Issue.record("Expected typeMismatch error")
        } catch let error {
            switch error {
            case let .typeMismatch(key, expected, actual):
                #expect(key == "FixtureBoolean")
                #expect(expected == String(reflecting: String.self))
                #expect(actual.isEmpty == false)
                #expect(actual != expected)
            default:
                Issue.record("Expected typeMismatch error")
            }
        }
    }

    @Test("Returns fallback value when a key is missing")
    func returnsDefaultForMissingKey() throws {
        let bundle = try #require(fixtureBundle())

        let value = bundle.value(for: InfoDictionaryKey<String>("MissingKey"), default: "fallback")

        #expect(value == "fallback")
    }

    @Test("Returns typed fallback values when keys are missing")
    func returnsTypedDefaultsForMissingKeys() throws {
        let bundle = try #require(fixtureBundle())

        let boolValue = bundle.bool(for: "MissingBoolean", default: false)
        let arrayValue = bundle.array(for: "MissingArray", default: ["fallback"])
        let dictionaryValue = bundle.dictionary(for: "MissingDictionary", default: ["fallback": "value"])
        let plistValue = bundle.plistValue(for: "MissingValueTree", default: ["enabled": true, "count": 2])

        #expect(boolValue == false)
        #expect(arrayValue == ["fallback"])
        #expect(dictionaryValue["fallback"] == .string("value"))
        #expect(plistValue == .dictionary(["enabled": .bool(true), "count": .integer(2)]))
    }

    @Test("Typed sugar still throws on type mismatch")
    func typedSugarThrowsOnMismatch() throws {
        let bundle = try #require(fixtureBundle())

        let boolKey: InfoDictionaryKey<Bool> = "FixtureString"
        let arrayKey: InfoDictionaryKey<[String]> = "FixtureBoolean"
        let dictionaryKey: InfoDictionaryKey<[String: InfoPlistValue]> = "FixtureStringArray"
        let plistKey: InfoDictionaryKey<InfoPlistValue> = "MissingKey"

        #expect(throws: InfoDictionaryError.self) {
            try bundle.bool(for: boolKey)
        }
        #expect(throws: InfoDictionaryError.self) {
            try bundle.array(for: arrayKey)
        }
        #expect(throws: InfoDictionaryError.self) {
            try bundle.dictionary(for: dictionaryKey)
        }
        #expect(throws: InfoDictionaryError.self) {
            try bundle.plistValue(for: plistKey)
        }
    }

    @Test("Predefined keys expose the expected raw key names")
    func predefinedKeysUseExpectedNames() {
        #expect(InfoDictionaryKey<String>.appName.name == "CFBundleName")
        #expect(InfoDictionaryKey<String>.identifier.name == "CFBundleIdentifier")
        #expect(InfoDictionaryKey<String>.displayName.name == "CFBundleDisplayName")
        #expect(InfoDictionaryKey<String>.cameraUsageDescription.name == "NSCameraUsageDescription")
        #expect(InfoDictionaryKey<Bool>.requiresIPhoneOS.name == "LSRequiresIPhoneOS")
        #expect(InfoDictionaryKey<[String]>.localizations.name == "CFBundleLocalizations")
        #expect(
            InfoDictionaryKey<[String: InfoPlistValue]>.locationTemporaryUsageDescriptionDictionary.name
                == "NSLocationTemporaryUsageDescriptionDictionary"
        )
        #expect(
            InfoDictionaryKey<String>.systemExtensionUsageDescription.name
                == "NSSystemExtensionUsageDescription"
        )
    }

    @Test("String literal keys use the literal value as the raw key name")
    func stringLiteralInitializesKeyName() {
        let key: InfoDictionaryKey<String> = "FixtureString"
        let boolKey: InfoDictionaryKey<Bool> = "FixtureBoolean"

        #expect(key.name == "FixtureString")
        #expect(boolKey.name == "FixtureBoolean")
    }

    @Test("Deprecated aliases are removed from the catalog source and README")
    func deprecatedAliasesAreRemoved() throws {
        let packageRoot = URL(filePath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let defineFileURL = packageRoot
            .appending(path: "Sources")
            .appending(path: "InfoDictionaryKey")
            .appending(path: "InfoDictionaryKey+Define.swift")
        let readmeURL = packageRoot.appending(path: "README.md")

        let defineFile = try String(contentsOf: defineFileURL, encoding: .utf8)
        let readme = try String(contentsOf: readmeURL, encoding: .utf8)

        #expect(defineFile.contains("NSCalendarsUsageDescription") == false)
        #expect(defineFile.contains("NSRemindersUsageDescription") == false)
        #expect(defineFile.contains("NSFilesAndFoldersUsageDescription") == false)
        #expect(defineFile.contains("NSExtensionUsageDescription") == false)
        #expect(readme.contains("[String: Any]") == false)
        #expect(readme.contains("NSCalendarsUsageDescription") == false)
        #expect(readme.contains("NSRemindersUsageDescription") == false)
    }

    private func fixtureBundle() -> Bundle? {
        guard
            let url = Bundle.module.url(forResource: "InfoDictionaryFixture", withExtension: "bundle")
        else {
            return nil
        }

        return Bundle(url: url)
    }
}
