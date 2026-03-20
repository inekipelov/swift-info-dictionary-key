import Foundation

// MARK: - Bundle identity and naming
public extension InfoDictionaryKey where Value == String {
    static let appName: Self = "CFBundleName"
    static let displayName: Self = "CFBundleDisplayName"
    static let spokenName: Self = "CFBundleSpokenName"
    static let identifier: Self = "CFBundleIdentifier"
    static let packageType: Self = "CFBundlePackageType"
    static let applicationCategoryType: Self = "LSApplicationCategoryType"
    static let watchAppBundleIdentifier: Self = "WKAppBundleIdentifier"
    static let watchCompanionAppBundleIdentifier: Self = "WKCompanionAppBundleIdentifier"
}

// MARK: - Bundle versioning and localization
public extension InfoDictionaryKey where Value == String {
    static let shortVersionString: Self = "CFBundleShortVersionString"
    static let version: Self = "CFBundleVersion"
    static let infoDictionaryVersion: Self = "CFBundleInfoDictionaryVersion"
    static let humanReadableCopyright: Self = "NSHumanReadableCopyright"
    static let developmentRegion: Self = "CFBundleDevelopmentRegion"
    static let appleHelpAnchor: Self = "CFAppleHelpAnchor"
    static let helpBookName: Self = "CFBundleHelpBookName"
    static let helpBookFolder: Self = "CFBundleHelpBookFolder"
}

// MARK: - OS and platform requirements
public extension InfoDictionaryKey where Value == String {
    static let minimumSystemVersion: Self = "LSMinimumSystemVersion"
    static let minimumSystemVersionByArchitecture: Self = "LSMinimumSystemVersionByArchitecture"
    static let minimumOSVersion: Self = "MinimumOSVersion"
}

// MARK: - Protected resources
public extension InfoDictionaryKey where Value == String {
    static let appleMusicUsageDescription: Self = "NSAppleMusicUsageDescription"
    static let bluetoothAlwaysUsageDescription: Self = "NSBluetoothAlwaysUsageDescription"
    static let bluetoothPeripheralUsageDescription: Self = "NSBluetoothPeripheralUsageDescription"
    static let calendarsFullAccessUsageDescription: Self = "NSCalendarsFullAccessUsageDescription"
    static let calendarsWriteOnlyAccessUsageDescription: Self = "NSCalendarsWriteOnlyAccessUsageDescription"
    static let remindersFullAccessUsageDescription: Self = "NSRemindersFullAccessUsageDescription"
    static let audioCaptureUsageDescription: Self = "NSAudioCaptureUsageDescription"
    static let cameraUsageDescription: Self = "NSCameraUsageDescription"
    static let mainCameraUsageDescription: Self = "NSMainCameraUsageDescription"
    static let microphoneUsageDescription: Self = "NSMicrophoneUsageDescription"
    static let contactsUsageDescription: Self = "NSContactsUsageDescription"
    static let faceIDUsageDescription: Self = "NSFaceIDUsageDescription"
    static let desktopFolderUsageDescription: Self = "NSDesktopFolderUsageDescription"
    static let documentsFolderUsageDescription: Self = "NSDocumentsFolderUsageDescription"
    static let downloadsFolderUsageDescription: Self = "NSDownloadsFolderUsageDescription"
    static let networkVolumesUsageDescription: Self = "NSNetworkVolumesUsageDescription"
    static let removableVolumesUsageDescription: Self = "NSRemovableVolumesUsageDescription"
    static let fileProviderDomainUsageDescription: Self = "NSFileProviderDomainUsageDescription"
    static let gameCenterFriendListUsageDescription: Self = "NSGKFriendListUsageDescription"
    static let healthClinicalHealthRecordsShareUsageDescription: Self = "NSHealthClinicalHealthRecordsShareUsageDescription"
    static let healthShareUsageDescription: Self = "NSHealthShareUsageDescription"
    static let healthUpdateUsageDescription: Self = "NSHealthUpdateUsageDescription"
    static let homeKitUsageDescription: Self = "NSHomeKitUsageDescription"
    static let locationAlwaysUsageDescription: Self = "NSLocationAlwaysUsageDescription"
    static let locationAlwaysAndWhenInUseUsageDescription: Self = "NSLocationAlwaysAndWhenInUseUsageDescription"
    static let locationUsageDescription: Self = "NSLocationUsageDescription"
    static let locationWhenInUseUsageDescription: Self = "NSLocationWhenInUseUsageDescription"
    static let criticalMessagingUsageDescription: Self = "NSCriticalMessagingUsageDescription"
    static let motionUsageDescription: Self = "NSMotionUsageDescription"
    static let fallDetectionUsageDescription: Self = "NSFallDetectionUsageDescription"
    static let localNetworkUsageDescription: Self = "NSLocalNetworkUsageDescription"
    static let nearbyInteractionUsageDescription: Self = "NSNearbyInteractionUsageDescription"
    static let nearbyInteractionAllowOnceUsageDescription: Self = "NSNearbyInteractionAllowOnceUsageDescription"
    static let nfcReaderUsageDescription: Self = "NFCReaderUsageDescription"
    static let photoLibraryAddUsageDescription: Self = "NSPhotoLibraryAddUsageDescription"
    static let photoLibraryUsageDescription: Self = "NSPhotoLibraryUsageDescription"
    static let appDataUsageDescription: Self = "NSAppDataUsageDescription"
    static let appleEventsUsageDescription: Self = "NSAppleEventsUsageDescription"
    static let systemAdministrationUsageDescription: Self = "NSSystemAdministrationUsageDescription"
    static let trackingUsageDescription: Self = "NSUserTrackingUsageDescription"
    static let sensorKitUsageDescription: Self = "NSSensorKitUsageDescription"
    static let siriUsageDescription: Self = "NSSiriUsageDescription"
    static let speechRecognitionUsageDescription: Self = "NSSpeechRecognitionUsageDescription"
    static let systemExtensionUsageDescription: Self = "NSSystemExtensionUsageDescription"
    static let driverExtensionUsageDescription: Self = "OSBundleUsageDescription"
    static let videoSubscriberAccountUsageDescription: Self = "NSVideoSubscriberAccountUsageDescription"
    static let worldSensingUsageDescription: Self = "NSWorldSensingUsageDescription"
    static let handsTrackingUsageDescription: Self = "NSHandsTrackingUsageDescription"
    static let accessoryTrackingUsageDescription: Self = "NSAccessoryTrackingUsageDescription"
    static let financialDataUsageDescription: Self = "NSFinancialDataUsageDescription"
    static let identityUsageDescription: Self = "NSIdentityUsageDescription"
}

// MARK: - Typed non-string values
public extension InfoDictionaryKey where Value == Bool {
    static let requiresIPhoneOS: Self = .init("LSRequiresIPhoneOS")
    static let watchKitApp: Self = .init("WKWatchKitApp")
    static let allowsMixedLocalizations: Self = .init("CFBundleAllowMixedLocalizations")
    static let widgetWantsLocation: Self = .init("NSWidgetWantsLocation")
    static let locationDefaultAccuracyReduced: Self = .init("NSLocationDefaultAccuracyReduced")
    static let requiresPersistentWiFi: Self = .init("UIRequiresPersistentWiFi")
    static let appleScriptEnabled: Self = .init("NSAppleScriptEnabled")
    static let usesNonExemptEncryption: Self = .init("ITSAppUsesNonExemptEncryption")
}

public extension InfoDictionaryKey where Value == [String] {
    static let localizations: Self = .init("CFBundleLocalizations")
}

public extension InfoDictionaryKey where Value == [String: Any] {
    static let locationTemporaryUsageDescriptionDictionary: Self = .init("NSLocationTemporaryUsageDescriptionDictionary")
    static let sensorKitUsageDetail: Self = .init("NSSensorKitUsageDetail")
}
