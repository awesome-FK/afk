# Native platform setup

The repository targets Android and iOS only. Generate the native runner folders with the agreed application organization identifier. Generate into a temporary project so Flutter tooling cannot replace AFK's existing `pubspec.yaml`.

From the repository root, using Bash:

```sh
ORG="com.example" # Replace with the agreed reverse-domain identifier.
TMP_DIR="$(mktemp -d)"

flutter create \
  --empty \
  --platforms=android,ios \
  --org "$ORG" \
  --project-name afk \
  "$TMP_DIR/afk"

cp -R "$TMP_DIR/afk/android" "$TMP_DIR/afk/ios" .
cp "$TMP_DIR/afk/.metadata" .
rm -rf "$TMP_DIR"
```

Then run:

```sh
flutter pub get
dart format .
flutter analyze
flutter test
```

Do not generate web, Windows, macOS, or Linux runners. Review the generated Android Gradle and iOS deployment settings before treating the runners as release-ready. Do not commit machine-specific files such as `android/local.properties`, generated build outputs, or signing credentials.
