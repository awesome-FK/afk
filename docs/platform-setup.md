# Native platform setup

The repository targets Android and iOS only. The native runner folders should be generated and committed with the actual application identifier once that identifier is agreed.

From the repository root, using the agreed reverse-domain organization identifier:

```sh
flutter create --empty --platforms=android,ios --org <your.reverse.domain> .
```

Then run:

```sh
flutter pub get
dart format .
flutter analyze
flutter test
```

Do not generate web, Windows, macOS, or Linux runners. Review the generated Android Gradle and iOS deployment settings before treating the runners as release-ready.
