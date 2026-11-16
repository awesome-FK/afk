# AFK contributor contract

## Before changing code
1. Read `README.md` and the relevant architecture/design-system document.
2. Identify the owning feature and dependency direction.
3. Inspect existing tokens and components before creating new ones.

## Non-negotiable rules
- No code generation, `build_runner`, Freezed, or generated provider/router code.
- No `dynamic` unless an interop boundary requires it and is documented.
- No service locator, hidden global mutable state, or provider that owns unrelated concerns.
- Features own their business rules. Shared code must be genuinely cross-feature.
- UI values come from design tokens; avoid one-off colors, spacing, radii, and durations.
- Material components are not the final AFK visual language. Use framework packages only where infrastructure or semantics justify them.
- Support English, Arabic, RTL, text scaling, semantics, and reduced motion.
- Do not swallow exceptions. Translate failures into explicit, user-safe states and preserve diagnostics.
- Do not add a dependency without documenting why the SDK or an existing dependency is insufficient.
- Never claim a command, test, build, or device check passed unless it was actually run.

## Required before completion
- Format changed Dart files.
- Run `flutter analyze` and relevant tests.
- Add/update tests for behavior changes.
- Update docs and ADRs when architecture or public APIs change.
- Summarize trade-offs, verification performed, and known limitations.
