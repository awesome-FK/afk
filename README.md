# AFK

A polished, feature-first Flutter foundation for building consistent Android and iOS applications.

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
- AFK semantic color roles, typography, spacing, radius, and motion tokens.
- Reusable button, surface, text-field, and segmented-control primitives.
- English/Arabic localization and RTL startup coverage.
- Persisted theme and locale preferences via the asynchronous SharedPreferences API.
- GitHub Actions formatting, analysis, and widget-test workflow.

Material UI is used as a framework dependency for platform integration, semantics, navigation shell, and input behavior. AFK components own the visible styling; do not use stock Material widgets as the product design language.

## Quick start

Generate the native runners with the application's agreed reverse-domain identifier:

```sh
flutter create --empty --platforms=android,ios --org <your.reverse.domain> .
flutter pub get
dart format .
flutter analyze
flutter test
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
