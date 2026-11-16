# AFK design system

## Visual direction

AFK uses a premium monochrome visual language: near-black, white, and carefully tiered neutral grays. The interface should feel quiet, precise, and intentional rather than like an unmodified Material application.

Material/Cupertino framework facilities may provide platform integration, semantics, focus, gestures, text input, and accessibility behavior. They do not define AFK's visual identity. Custom AFK components own the visible treatment.

## Foundations

- **Color:** palette values live in `AfkColors`; components and feature screens consume semantic `AfkThemeColors` roles.
- **Typography:** text styles live in `AfkTypography`; do not create arbitrary type scales in features.
- **Spacing:** use `AfkSpacing`.
- **Radius:** use `AfkRadius`.
- **Motion:** use `AfkMotion` and respect `MediaQuery.disableAnimations`.
- **Theme:** `AfkTheme.light()` and `AfkTheme.dark()` register the semantic theme extension.

The current typography intentionally uses the platform's default font fallback. A bundled Latin/Arabic family is not selected yet: font choice must be validated for Arabic shaping, weights, readability, binary size, and redistribution license before being added.

## Semantic color roles

- `canvas`: app/page background.
- `surface`: default component surface.
- `surfaceRaised`: subtle elevated or grouped surface.
- `primaryText`: high-emphasis content and primary action background.
- `secondaryText`: supporting content.
- `border`: separators and outlines.
- `inverseSurface`: content color on primary action surfaces / selected segment surface.
- `disabled`: inactive content.

Avoid raw palette references from feature code. A new semantic role must be justified across multiple components.

## Component API expectations

Components expose intent-based properties, have predictable defaults, support disabled/loading/error states where relevant, and document behavior that is not obvious from the API. Avoid prop combinations that permit visually invalid states.

The initial public component surface is exported from `lib/design_system/afk_design_system.dart`. See [component catalog](component-catalog.md).

## Internationalization and accessibility

- English and Arabic are first-class locales.
- Directionality follows the active locale; use directional padding/alignment rather than hardcoded left/right.
- Verify long translations, mixed-direction text, large text scaling, focus order, semantics, and reduced-motion behavior.
- Never communicate state by color alone.
- Interactive targets should remain comfortably tappable and keyboard/focus reachable where applicable.

## Validation checklist

Before a component is considered stable, cover:
- Light and dark theme contrast.
- English and Arabic labels, including RTL layout.
- Text scaling and narrow screens.
- Disabled, loading, error, and selected states as relevant.
- Semantics labels/roles/state and focus behavior.
- Reduced-motion behavior.
- Android and iOS physical-device rendering.
