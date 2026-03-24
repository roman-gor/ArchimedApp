# Archimed Application

**Archimedes** is a cross-platform mobile application designed to interact with the Archimedes device via BLE (Bluetooth Low Energy).

## About project
The app allows users to connect to the Archimedes hardware, read real-time sensor data, and manage device settings.
It leverages **Kotlin Multiplatform (KMM)** for shared business logic and BLE communication, paired with a **Flutter** UI for a seamless experience on both iOS and Android.

## Tech Stack
- **Languages**: Kotlin, Dart
- **UI**: Flutter
- **Shared Logic**: Kotlin Multiplatform (KMM)
- **Communication**: BLE (Bluetooth Low Energy)

## Features
- Scanning and connecting to the Archimedes device via BLE
- Real-time display of sensor metrics (temperature, humidity, pressure, etc.)
- Cross-platform shared core logic (KMM) ensuring consistency between Android and iOS

## Setup
### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- Android Studio (for Android build and KMM shared module editing)
- Xcode (for iOS build)
### Installation
- Clone the repository
- Install Flutter dependencies: ```flutter pub get```
- Generate localization files: ```flutter gen-l10n```
- Generate freezed dependencies: ```dart run build_runner build --delete-conflicting-outputs```
- To work on iOS platform (Xcode) you need to generate podfile dependencies:
  - Install CocoaPods (```brew install cocoapods```) with Terminal
  - Run ```pod install --repo-update```
