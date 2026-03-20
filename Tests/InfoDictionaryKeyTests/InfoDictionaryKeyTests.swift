import Foundation
import Testing
@testable import InfoDictionaryKeys

@Suite("InfoDictionaryKey")
struct InfoDictionaryKeyTests {
    @Test("Reads a known string key from a fixture bundle")
    func readsKnownStringValue() throws {
        let bundle = try #require(fixtureBundle())

        let value = try bundle.string(for: .appName)

        #expect(value == "FixtureBundle")
    }

    @Test("Reads a known non-string value from a fixture bundle")
    func readsKnownTypedValue() throws {
        let bundle = try #require(fixtureBundle())

        let value = try bundle.value(for: InfoDictionaryKey<Bool>.init("FixtureBoolean"))

        #expect(value == true)
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

    @Test("Predefined keys expose the expected raw key names")
    func predefinedKeysUseExpectedNames() {
        #expect(InfoDictionaryKey<String>.appName.name == "CFBundleName")
        #expect(InfoDictionaryKey<String>.identifier.name == "CFBundleIdentifier")
        #expect(InfoDictionaryKey<String>.displayName.name == "CFBundleDisplayName")
        #expect(InfoDictionaryKey<String>.cameraUsageDescription.name == "NSCameraUsageDescription")
        #expect(InfoDictionaryKey<Bool>.requiresIPhoneOS.name == "LSRequiresIPhoneOS")
        #expect(InfoDictionaryKey<[String]>.localizations.name == "CFBundleLocalizations")
        #expect(
            InfoDictionaryKey<[String: Any]>.locationTemporaryUsageDescriptionDictionary.name
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

        #expect(key.name == "FixtureString")
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
