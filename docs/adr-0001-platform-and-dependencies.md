# ADR 0001: Platform scope and foundational dependencies

- Status: Accepted
- Date: 2026-11-16

## Context

AFK is a reusable foundation for high-quality Flutter applications. It needs a clear platform target, predictable navigation, and testable state management without introducing code-generation overhead.

## Decision

- Support Android and iOS only; web and desktop are out of scope.
- Use Riverpod for application state and dependency composition.
- Use GoRouter for declarative navigation.
- Do not adopt Freezed, build_runner, or generated routing/provider code.
- Keep the visual system custom and independent of Material's default component styling.

## Consequences

The initial setup remains small and handwritten. Native runner projects must be generated with the team's installed Flutter SDK and committed with the intended application identifier. Dependency versions must be checked against the actual SDK in CI before release.
