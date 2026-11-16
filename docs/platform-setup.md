# Native platform setup

AFK targets Android and iOS. The repository's default identity is declared once in `lib/app/afk_example_configuration.dart`:

- Display name: `Example App`
- Android application ID: `com.example.app`
- iOS bundle identifier: `com.example.app`

## Generate runners

The Native Platform Foundation workflow uses the official Flutter 3.50.0 tooling to generate both native runner directories. It uses `--org com.example` and `--project-name app`, preserving AFK's existing `pubspec.yaml`, lockfile, tests, and ignore rules. The native display names are then set in Android's main manifest and iOS's `Info.plist`.

For a local regeneration, use Flutter 3.50.0 and generate into a temporary project so the existing AFK Dart package is not rewritten:

```sh
TMP_DIR="$(mktemp -d)"
flutter create --no-pub --platforms=android,ios \
  --org com.example --project-name app "$TMP_DIR/app"
cp -R "$TMP_DIR/app/android" "$TMP_DIR/app/ios" .
cp "$TMP_DIR/app/.metadata" .
rm -rf "$TMP_DIR"
```

Set the Android `application` label in `android/app/src/main/AndroidManifest.xml` and iOS `CFBundleDisplayName` in `ios/Runner/Info.plist` to `Example App` before validating. Do not replace AFK's `pubspec.yaml`, `pubspec.lock`, `lib/`, or `test/` with files from the temporary project.

## Identity validation

Run the repository validator from the root after generating or changing native files:

```sh
python3 scripts/validate_native_identity.py
```

It reads the identity values from the Dart `AppIdentity` configuration and compares them with the actual Android Gradle namespace/application ID, Android manifest label, iOS Xcode build-configuration bundle IDs, and iOS display name. It checks both Groovy and Kotlin Gradle DSL filenames and accounts for the separate iOS RunnerTests bundle identifier.

## Build and SDK policy

CI uses Flutter 3.50.0. It builds an unsigned Android Debug APK on Ubuntu and an unsigned iOS Simulator app on macOS using `flutter build ios --simulator --no-codesign`. No Release signing credentials or local machine configuration are required for these checks.

Reviewed Flutter 3.50.0 template settings in the generated runners: Android uses Gradle 9.5.0, Android Gradle Plugin 9.3.1, Kotlin 2.4.20, and Java 17; compile/target SDK values come from the pinned Flutter toolchain. The generated iOS project uses Swift Package Manager integration (not a Podfile) and sets an iOS 15.0 deployment target. Recheck these values when upgrading Flutter and confirm compatibility through the hosted builds. Do not generate web, Windows, macOS, or Linux runners. Do not commit `android/local.properties`, `android/key.properties`, generated ephemeral Swift packages, Pods (if introduced by a future template), build output, or signing credentials.
