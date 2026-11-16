# AFK design system

## Visual direction

AFK uses a premium monochrome visual language: near-black, white, and carefully tiered neutral grays. The interface should feel quiet, precise, and intentional rather than like an unmodified Material application.

Material/Cupertino framework facilities may provide platform integration, semantics, focus, gestures, and accessibility behavior. They do not define AFK's visual identity.

## Token policy

- Use semantic roles (canvas, surface, elevated surface, primary text, secondary text, divider, accent, danger, success), not raw palette values in features.
- Spacing, radii, typography, elevation, and motion are centralized.
- Components consume tokens; screens compose components rather than inventing visual values.
- Light and dark themes must preserve semantic contrast.

## Internationalization and accessibility

- English and Arabic are first-class locales.
- Directionality follows the active locale; do not hardcode left/right for directional layout.
- Verify long translations, mixed-direction text, large text scaling, focus order, semantics, and reduced-motion behavior.
- Never communicate state by color alone.

## Component API expectations

Components should expose intent-based properties, have predictable defaults, support disabled/loading/error states where relevant, and document behavior that is not obvious from the API. Avoid prop combinations that permit visually invalid states.
