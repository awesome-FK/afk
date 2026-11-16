# AFK

A polished, feature-first Flutter foundation for building consistent Android and iOS applications.

## Distribution model

AFK is intended to be distributed as a GitHub Template. Each generated application owns an independent repository, app identity, native identifiers, configuration, and release lifecycle. Generated applications do not depend on AFK at runtime. Stable shared capabilities may become separately versioned packages only when reuse justifies that boundary; changes to AFK never propagate automatically into generated applications.

The application entry point must supply a validated `AppConfiguration`. It combines a typed `AppIdentity`, an `AppEnvironment`, and the application's own light/dark themes. Android `applicationId` and iOS `PRODUCT_BUNDLE_IDENTIFIER` must match the identifiers declared in that identity when native runners are generated. The repository demo explicitly selects `exampleAppConfiguration` so this repository remains runnable. A project created from the GitHub Template receives this source as its own code; replace `exampleAppConfiguration` and `ExampleAppTheme` with the generated app's identity and theme before shipping. There is no AFK runtime package dependency, and future changes to this repository do not propagate to generated apps.

## Product principles

- **Feature-first architecture** with clear ownership and dependency boundaries.
- **Riverpod** for explicit, testable application state.
- **GoRouter** for centralized, declarative navigation.
- **No code generation by default**: handwritten Dart, no Freezed.
- **Bilingual by design**: English and Arabic, with RTL/LTR directionality.
- **Light and dark themes** built from semantic design tokens.
- **Custom visual identity**: monochrome, restrained, accessible, and independent of Material styling.
- **Quality as infrastructure**: contributor contracts, automated checks, documentation, and focused tests.

## Platform scope

Android and iOS only. Web and desktop are intentionally out of scope.

## Current foundation

- App bootstrap and Riverpod composition.
- Provider-managed GoRouter lifecycle and localized route recovery.
- The sample design-system implementation provides semantic color roles, typography, spacing, radius, and motion tokens; generated apps own and may replace these values.
- Reusable button, surface, text-field, and segmented-control primitives.
- English/Arabic localization and RTL startup coverage.
- Persisted theme and locale preferences via the asynchronous SharedPreferences API.
- GitHub Actions formatting, analysis, and widget-test workflow.

Material UI is used as a framework dependency for platform integration, semantics, navigation shell, and input behavior. The included components demonstrate the intended styling boundary; generated apps own their final visual treatment and should not use stock Material widgets as their product design language.

## Quick start

Generate the official Android and iOS runners with Flutter 3.50.0 and keep their native identifiers synchronized with `exampleAppConfiguration`. The automated Native Platform Foundation workflow generates the runners, validates the real native project files, runs Dart quality checks, and builds Android Debug and iOS Simulator targets. See [Native platform setup](docs/platform-setup.md) for local regeneration and validation instructions.

```sh
flutter pub get
dart format .
flutter analyze
flutter test
python3 scripts/validate_native_identity.py
```

Do not generate web or desktop runners.

## Engineering rules and architecture

- [AGENTS.md](AGENTS.md) — mandatory rules for contributors and AI agents.
- [Architecture](docs/architecture.md) — dependency direction, state, routing, and error handling.
- [Design system](docs/design-system.md) — token and visual-system policy.
- [Component catalog](docs/component-catalog.md) — public component APIs.
- [Engineering quality](docs/engineering-quality.md) — definition of done and verification.
- [Platform setup](docs/platform-setup.md) — native runner generation.
- [Architecture decisions](docs/) — rationale for foundational dependencies and persistence.

## Status

The foundation is actively being built. Do not treat it as release-ready until CI passes and Android/iOS runners have been generated and verified on supported toolchains and physical devices.
