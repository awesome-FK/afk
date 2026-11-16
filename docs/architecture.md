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

Expected failures are modeled as values/states at feature boundaries. Unexpected failures retain stack traces and are reported through an explicit logging adapter. UI renders safe, localized recovery states; it never displays raw exception text.
