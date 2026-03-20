import Foundation

public extension InfoDictionaryKey where Value == String {
    static let appName: Self = "CFBundleName"
    static let shortVersionString: Self = "CFBundleShortVersionString"
    static let version: Self = "CFBundleVersion"
    static let identifier: Self = "CFBundleIdentifier"
}

public extension InfoDictionaryKey where Value == String {
    static let appleMusicUsageDescription: Self = "NSAppleMusicUsageDescription"
    static let bluetoothAlwaysUsageDescription: Self = "NSBluetoothAlwaysUsageDescription"
    static let bluetoothPeripheralUsageDescription: Self = "NSBluetoothPeripheralUsageDescription"
    static let calendarsUsageDescription: Self = "NSCalendarsUsageDescription"
    static let cameraUsageDescription: Self = "NSCameraUsageDescription"
    static let contactsUsageDescription: Self = "NSContactsUsageDescription"
    static let faceIDUsageDescription: Self = "NSFaceIDUsageDescription"
    static let filesAndFoldersUsageDescription: Self = "NSFilesAndFoldersUsageDescription"
    static let healthShareUsageDescription: Self = "NSHealthShareUsageDescription"
    static let healthUpdateUsageDescription: Self = "NSHealthUpdateUsageDescription"
    static let homeKitUsageDescription: Self = "NSHomeKitUsageDescription"
    static let locationAlwaysUsageDescription: Self = "NSLocationAlwaysUsageDescription"
    static let locationAlwaysAndWhenInUseUsageDescription: Self = "NSLocationAlwaysAndWhenInUseUsageDescription"
    static let locationWhenInUseUsageDescription: Self = "NSLocationWhenInUseUsageDescription"
    static let microphoneUsageDescription: Self = "NSMicrophoneUsageDescription"
    static let motionUsageDescription: Self = "NSMotionUsageDescription"
    static let nearbyInteractionUsageDescription: Self = "NSNearbyInteractionUsageDescription"
    static let photoLibraryAddUsageDescription: Self = "NSPhotoLibraryAddUsageDescription"
    static let photoLibraryUsageDescription: Self = "NSPhotoLibraryUsageDescription"
    static let remindersUsageDescription: Self = "NSRemindersUsageDescription"
    static let siriUsageDescription: Self = "NSSiriUsageDescription"
    static let speechRecognitionUsageDescription: Self = "NSSpeechRecognitionUsageDescription"
    static let systemExtensionUsageDescription: Self = "NSExtensionUsageDescription"
    static let trackingUsageDescription: Self = "NSUserTrackingUsageDescription"
}
