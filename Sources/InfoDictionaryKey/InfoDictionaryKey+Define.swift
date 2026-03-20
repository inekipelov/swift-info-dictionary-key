import Foundation

// MARK: - Bundle identity and naming
public extension InfoDictionaryKey where Value == String {
    /// A user-visible short name for the bundle.
    static let appName: Self = "CFBundleName"

    /// The user-visible name for the bundle, used by Siri and visible on the Home screen.
    static let displayName: Self = "CFBundleDisplayName"

    /// A replacement for the app name in text-to-speech operations.
    static let spokenName: Self = "CFBundleSpokenName"

    /// A unique identifier for a bundle.
    static let identifier: Self = "CFBundleIdentifier"

    /// The type of bundle.
    static let packageType: Self = "CFBundlePackageType"

    /// The category that best describes your app for the App Store.
    static let applicationCategoryType: Self = "LSApplicationCategoryType"

    /// The bundle identifier of the watchOS app.
    static let watchAppBundleIdentifier: Self = "WKAppBundleIdentifier"

    /// The bundle identifier of the watchOS app’s companion iOS app.
    static let watchCompanionAppBundleIdentifier: Self = "WKCompanionAppBundleIdentifier"
}

// MARK: - Bundle versioning and localization
public extension InfoDictionaryKey where Value == String {
    /// The release or version number of the bundle.
    static let shortVersionString: Self = "CFBundleShortVersionString"

    /// The build version that identifies an iteration of the bundle.
    static let version: Self = "CFBundleVersion"

    /// The current version of the Information Property List structure.
    static let infoDictionaryVersion: Self = "CFBundleInfoDictionaryVersion"

    /// A human-readable copyright notice for the bundle.
    static let humanReadableCopyright: Self = "NSHumanReadableCopyright"

    /// The default language and region for the bundle.
    static let developmentRegion: Self = "CFBundleDevelopmentRegion"

    /// The name of the bundle’s HTML help file.
    static let appleHelpAnchor: Self = "CFAppleHelpAnchor"

    /// The name of the help file that opens in Help Viewer.
    static let helpBookName: Self = "CFBundleHelpBookName"

    /// The folder containing the bundle’s help files.
    static let helpBookFolder: Self = "CFBundleHelpBookFolder"
}

// MARK: - OS and platform requirements
public extension InfoDictionaryKey where Value == String {
    /// The minimum macOS version required for the app to run.
    static let minimumSystemVersion: Self = "LSMinimumSystemVersion"

    /// The minimum macOS version required for the app to run on specific architectures.
    static let minimumSystemVersionByArchitecture: Self = "LSMinimumSystemVersionByArchitecture"

    /// The minimum operating system version required for the app to run on Apple mobile platforms.
    static let minimumOSVersion: Self = "MinimumOSVersion"
}

// MARK: - Protected resources
public extension InfoDictionaryKey where Value == String {
    /// A message that tells people why the app requests access to their media library.
    static let appleMusicUsageDescription: Self = "NSAppleMusicUsageDescription"

    /// A message that tells people why the app needs access to Bluetooth.
    static let bluetoothAlwaysUsageDescription: Self = "NSBluetoothAlwaysUsageDescription"

    /// A message that tells people why the app requests the ability to connect to Bluetooth peripherals.
    static let bluetoothPeripheralUsageDescription: Self = "NSBluetoothPeripheralUsageDescription"

    /// A message that tells people why the app requests full access to calendar data.
    static let calendarsFullAccessUsageDescription: Self = "NSCalendarsFullAccessUsageDescription"

    /// A message that tells people why the app requests write-only access to create calendar events.
    static let calendarsWriteOnlyAccessUsageDescription: Self = "NSCalendarsWriteOnlyAccessUsageDescription"

    /// A message that tells people why the app requests full access to reminders data.
    static let remindersFullAccessUsageDescription: Self = "NSRemindersFullAccessUsageDescription"

    /// A message that tells people why the app requests access to capture system audio on macOS.
    static let audioCaptureUsageDescription: Self = "NSAudioCaptureUsageDescription"

    /// A message that tells people why the app requests access to the device’s camera.
    static let cameraUsageDescription: Self = "NSCameraUsageDescription"

    /// A message that tells people why the app requests access to the device’s main camera.
    static let mainCameraUsageDescription: Self = "NSMainCameraUsageDescription"

    /// A message that tells people why the app requests access to the device’s microphone.
    static let microphoneUsageDescription: Self = "NSMicrophoneUsageDescription"

    /// A message that tells people why the app requests access to their contacts.
    static let contactsUsageDescription: Self = "NSContactsUsageDescription"

    /// A message that tells people why the app requests the ability to authenticate with Face ID.
    static let faceIDUsageDescription: Self = "NSFaceIDUsageDescription"

    /// A message that tells people why the app needs access to their Desktop folder.
    static let desktopFolderUsageDescription: Self = "NSDesktopFolderUsageDescription"

    /// A message that tells people why the app needs access to their Documents folder.
    static let documentsFolderUsageDescription: Self = "NSDocumentsFolderUsageDescription"

    /// A message that tells people why the app needs access to the user’s Downloads folder.
    static let downloadsFolderUsageDescription: Self = "NSDownloadsFolderUsageDescription"

    /// A message that tells people why the app needs access to files on a network volume.
    static let networkVolumesUsageDescription: Self = "NSNetworkVolumesUsageDescription"

    /// A message that tells people why the app needs access to files on a removable volume.
    static let removableVolumesUsageDescription: Self = "NSRemovableVolumesUsageDescription"

    /// A message that tells people why the app needs access to files managed by a file provider.
    static let fileProviderDomainUsageDescription: Self = "NSFileProviderDomainUsageDescription"

    /// A message that tells people why the app needs access to their Game Center friends list.
    static let gameCenterFriendListUsageDescription: Self = "NSGKFriendListUsageDescription"

    /// A message that explains why the app requests permission to read clinical records.
    static let healthClinicalHealthRecordsShareUsageDescription: Self = "NSHealthClinicalHealthRecordsShareUsageDescription"

    /// A message that explains why the app requests permission to read HealthKit samples.
    static let healthShareUsageDescription: Self = "NSHealthShareUsageDescription"

    /// A message that explains why the app requests permission to save HealthKit samples.
    static let healthUpdateUsageDescription: Self = "NSHealthUpdateUsageDescription"

    /// A message that tells people why the app requests access to their HomeKit configuration data.
    static let homeKitUsageDescription: Self = "NSHomeKitUsageDescription"

    /// A message that tells people why the app requests always-on location access.
    static let locationAlwaysUsageDescription: Self = "NSLocationAlwaysUsageDescription"

    /// A message that tells people why the app requests location access at all times.
    static let locationAlwaysAndWhenInUseUsageDescription: Self = "NSLocationAlwaysAndWhenInUseUsageDescription"

    /// A message that tells people why the app requests access to their location information.
    static let locationUsageDescription: Self = "NSLocationUsageDescription"

    /// A message that tells people why the app requests location access while running in the foreground.
    static let locationWhenInUseUsageDescription: Self = "NSLocationWhenInUseUsageDescription"

    /// A message that tells people why the app needs to send SMS messages.
    static let criticalMessagingUsageDescription: Self = "NSCriticalMessagingUsageDescription"

    /// A message that tells people why the app requests access to the device’s motion data.
    static let motionUsageDescription: Self = "NSMotionUsageDescription"

    /// A message that explains the app’s request for access to fall detection event data.
    static let fallDetectionUsageDescription: Self = "NSFallDetectionUsageDescription"

    /// A message that tells people why the app requests access to the local network.
    static let localNetworkUsageDescription: Self = "NSLocalNetworkUsageDescription"

    /// A request for permission to begin an interaction session with nearby devices.
    static let nearbyInteractionUsageDescription: Self = "NSNearbyInteractionUsageDescription"

    /// A one-time request for permission to begin an interaction session with nearby devices.
    static let nearbyInteractionAllowOnceUsageDescription: Self = "NSNearbyInteractionAllowOnceUsageDescription"

    /// A message that tells people why the app requests access to the device’s NFC hardware.
    static let nfcReaderUsageDescription: Self = "NFCReaderUsageDescription"

    /// A message that tells people why the app requests add-only access to their photo library.
    static let photoLibraryAddUsageDescription: Self = "NSPhotoLibraryAddUsageDescription"

    /// A message that tells people why the app requests access to their photo library.
    static let photoLibraryUsageDescription: Self = "NSPhotoLibraryUsageDescription"

    /// A message that tells people why the app needs access to files in other apps’ sandbox containers.
    static let appDataUsageDescription: Self = "NSAppDataUsageDescription"

    /// A message that tells people why the app requests the ability to send Apple events.
    static let appleEventsUsageDescription: Self = "NSAppleEventsUsageDescription"

    /// A message in macOS that tells people why the app requests permission to manipulate system configuration.
    static let systemAdministrationUsageDescription: Self = "NSSystemAdministrationUsageDescription"

    /// A message that informs the user why the app requests permission to use data for tracking.
    static let trackingUsageDescription: Self = "NSUserTrackingUsageDescription"

    /// A short description of the purpose of your app’s SensorKit research study.
    static let sensorKitUsageDescription: Self = "NSSensorKitUsageDescription"

    /// A message that tells people why the app requests permission to send user data to Siri.
    static let siriUsageDescription: Self = "NSSiriUsageDescription"

    /// A message that tells people why the app requests permission to send speech data to Apple’s servers.
    static let speechRecognitionUsageDescription: Self = "NSSpeechRecognitionUsageDescription"

    /// A message that tells people why the app is trying to install a system extension bundle.
    static let systemExtensionUsageDescription: Self = "NSSystemExtensionUsageDescription"

    /// A message that tells people why the app is trying to install a driver extension bundle.
    static let driverExtensionUsageDescription: Self = "OSBundleUsageDescription"

    /// A message that tells people why the app requests access to their TV provider account.
    static let videoSubscriberAccountUsageDescription: Self = "NSVideoSubscriberAccountUsageDescription"

    /// A message that tells people why the app requests access to image tracking, plane detection, or scene reconstruction.
    static let worldSensingUsageDescription: Self = "NSWorldSensingUsageDescription"

    /// A message that tells people why the app requests access to track hand position and location.
    static let handsTrackingUsageDescription: Self = "NSHandsTrackingUsageDescription"

    /// A message that tells people why the app requests access to track accessory position and location.
    static let accessoryTrackingUsageDescription: Self = "NSAccessoryTrackingUsageDescription"

    /// A message that tells people why the app requests access to financial data stored in Wallet.
    static let financialDataUsageDescription: Self = "NSFinancialDataUsageDescription"

    /// A message that tells people why the app requests identity information.
    static let identityUsageDescription: Self = "NSIdentityUsageDescription"
}

// MARK: - Typed non-string values
public extension InfoDictionaryKey where Value == Bool {
    /// A Boolean value indicating whether the app must run in iOS.
    static let requiresIPhoneOS: Self = "LSRequiresIPhoneOS"

    /// A Boolean value that indicates whether the bundle is a watchOS app.
    static let watchKitApp: Self = "WKWatchKitApp"

    /// A Boolean value that indicates whether the bundle supports retrieving localized strings from frameworks.
    static let allowsMixedLocalizations: Self = "CFBundleAllowMixedLocalizations"

    /// A Boolean value that indicates whether a widget uses the user’s location information.
    static let widgetWantsLocation: Self = "NSWidgetWantsLocation"

    /// A Boolean value that indicates whether the app requests reduced location accuracy by default.
    static let locationDefaultAccuracyReduced: Self = "NSLocationDefaultAccuracyReduced"

    /// A Boolean value that indicates whether the app requires a Wi-Fi connection.
    static let requiresPersistentWiFi: Self = "UIRequiresPersistentWiFi"

    /// A Boolean value indicating whether AppleScript is enabled.
    static let appleScriptEnabled: Self = "NSAppleScriptEnabled"

    /// A Boolean value indicating whether the app uses encryption.
    static let usesNonExemptEncryption: Self = "ITSAppUsesNonExemptEncryption"
}

public extension InfoDictionaryKey where Value == [String] {
    /// The localizations handled manually by your app.
    static let localizations: Self = "CFBundleLocalizations"
}

public extension InfoDictionaryKey where Value == [String: Any] {
    /// A collection of messages that explain why the app requests temporary access to location.
    static let locationTemporaryUsageDescriptionDictionary: Self = "NSLocationTemporaryUsageDescriptionDictionary"

    /// A dictionary that includes keys for the specific SensorKit information your app collects.
    static let sensorKitUsageDetail: Self = "NSSensorKitUsageDetail"
}
