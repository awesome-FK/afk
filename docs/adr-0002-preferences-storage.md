# ADR 0002: Persist non-critical app preferences

- Status: Accepted
- Date: 2026-11-16

## Context

Theme mode and locale should survive app restarts. These values are small, non-critical settings and do not require a database or encrypted credential store.

## Decision

- Use the Flutter-maintained `shared_preferences` plugin through its `SharedPreferencesAsync` API.
- Keep storage behind `AppPreferencesRepository`; presentation and feature code depend on the abstraction, not the plugin.
- Store a versioned JSON payload under one key so the theme and locale update together.
- Use handwritten Riverpod `AsyncNotifier` state; no code generation.
- If reading fails, report diagnostics and continue with safe defaults. If writing fails, keep the in-memory setting and report diagnostics.
- Serialize writes so rapid consecutive changes cannot persist out of order.

## Consequences

The application may briefly display defaults while preferences load; preference controls remain disabled until initialization completes. This store is only for non-critical settings. It must never hold authentication secrets or other sensitive/critical data.
