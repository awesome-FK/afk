# Architecture contract

## Dependency direction

`app` composes the application. `routing` maps locations to feature entry points. `features` own business behavior. `design_system` owns presentation primitives and visual policy. A shared `core` is intentionally absent until a genuinely cross-feature capability exists.

Allowed direction:
- Feature presentation → feature application/domain + design system.
- Feature data → feature domain + external adapters.
- Feature domain → Dart-only abstractions; no Flutter/UI imports.
- App composition → features, routing, design system, infrastructure.
- Design system → Flutter widgets and narrowly selected platform primitives; never feature code.

Features must not import another feature's internal files. Cross-feature behavior is exposed through a deliberate public feature API or moved to a shared capability only when ownership is clear.

## App identity and configuration

Each generated application supplies one immutable `AppConfiguration` at its composition root and passes it to `bootstrap`. The configuration owns the display identity, Android application ID, iOS bundle identifier, environment selection, light/dark themes, and explicit debug-banner choice. The foundation does not keep a mutable global current-app configuration.

Android and iOS identifiers are validated independently. The Dart contract validates their syntax; once native runners exist, the Android `applicationId` and iOS `PRODUCT_BUNDLE_IDENTIFIER` must be set to the matching values. Dart validation alone cannot prove native build configuration.

`AppEnvironment` is an environment selector, not a bag of runtime secrets. Future environment-specific settings should be represented by immutable, typed configuration values (for example, a typed API endpoint configuration) and selected/injected at the app composition root alongside `AppConfiguration`. Keep those values separate from identity and never embed credentials, private keys, or other secrets in a mobile binary. Debug and logging behavior must be explicit configuration or injected services, not mutable global switches.

The default preferences repository derives its versioned storage key from the configured Android application ID, preventing the foundation's own identifier from being baked into generated apps. A generated app may replace this policy when it has a deliberate storage migration strategy.

The AFK theme and sample identity are demonstration assets only. A generated app must provide its own `ThemeData` and identity; application composition must not silently select the sample theme.

## Feature template

```text
features/<feature>/
  data/           # repositories, DTO mapping, adapters (when needed)
  domain/         # entities, use cases, contracts (when justified)
  presentation/   # screens, feature widgets, feature state
  <feature>.dart  # deliberate public surface
```

Do not create empty layers. A simple feature may start with presentation only.

## State management

- Riverpod is the composition and state lifecycle mechanism.
- Use the narrowest provider type that expresses the state.
- App-wide theme and locale preferences are loaded through an asynchronous repository boundary and exposed as an `AsyncNotifier`; the app renders safe defaults while storage initializes.
- Persist only non-critical settings in key-value storage. Authentication secrets, financial records, and other critical data require a different storage/security design.
- Keep ephemeral widget state local.
- Providers must not become service locators or global dumping grounds.
- Keep side effects explicit and testable; do not perform writes during provider build.
- Prefer immutable state and small handwritten Notifiers. No generated providers.

## Navigation

- Route paths and names are centralized in `routing/`.
- Route definitions live in `routing/`; feature screens remain feature-owned.
- Route guards are deterministic and must not hide network calls in redirects.
- Navigation arguments are typed and validated at the route boundary.
- No route code generation.

## Error handling

- `AppErrorReporter` is installed once during bootstrap and receives uncaught Flutter framework and platform asynchronous errors.
- Framework errors retain their original `FlutterErrorDetails`; platform errors are wrapped with their exception and stack trace intact.
- The default sink uses Flutter's standard error presentation. Replace it through the reporter's handler when an app-specific diagnostics service is introduced; do not add logging dependencies to feature code.
- Expected failures are modeled as values/states at feature boundaries. UI renders safe, localized recovery states; it never displays raw exception text.
