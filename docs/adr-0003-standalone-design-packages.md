# ADR 0003: Use standalone Flutter design packages as infrastructure

- Status: Accepted
- Date: 2026-11-16

## Context

Flutter 3.50 formally deprecates the in-SDK Material and Cupertino design libraries in favor of standalone packages. AFK also requires a custom visual identity rather than stock Material styling.

## Decision

- Depend on the official `material_ui` package for platform shell, navigation integration, gestures, focus, text input, accessibility semantics, and framework localization support.
- Use `GlobalMaterialLocalizations.delegates` alongside AFK's handwritten localization delegate; this includes the framework's Material, Cupertino, and Widgets localization delegates.
- AFK-owned components and semantic tokens define all visible product styling.
- Do not import the deprecated `package:flutter/material.dart` library in AFK source.
- Do not add `cupertino_ui` directly unless AFK begins using its widgets directly; it is available transitively through the Material package where needed.

## Consequences

The app can receive framework fixes independently of Flutter SDK releases while keeping its own visual system. Third-party packages that still expose legacy Material types may require a compatibility bridge or a migrated alternative; evaluate type compatibility before adoption.
