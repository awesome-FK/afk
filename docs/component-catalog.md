# AFK component catalog

The design system currently exposes a deliberately small set of primitives. Prefer composing these over adding screen-local copies.

## AfkSurface

A semantic surface with token-backed background, radius, and optional border.

- Use for grouped content and contained sections.
- Padding, radius, border visibility, and background override are explicit.
- Avoid using it as a generic wrapper when no surface treatment is needed.

## AfkButton

Intent-based action control.

- Variants: `primary`, `secondary`, `quiet`.
- Sizes: `small`, `medium`, `large`.
- Supports leading/trailing icon widgets, loading, disabled state, and full-width layout.
- A null callback disables the control. Loading also blocks activation.
- Loading state should be accompanied by an appropriate accessible label when the action context requires it.

## AfkSegmentedControl

A compact, mutually exclusive choice control for a small stable set of options.

- Values are typed.
- Each option has a localized label.
- The selected state is exposed to semantics.
- Motion respects the platform reduced-animation preference.

## AfkTextField

A token-backed text input wrapper.

- Supports label, hint, error, controller, callbacks, keyboard configuration, autofill, prefix/suffix, and obscured input.
- The feature owns the controller lifecycle and validation logic.
- Use a feature-specific wrapper when validation or domain behavior is required.

## API evolution

These APIs are initial foundations, not frozen contracts. Before broad adoption, verify keyboard/focus behavior, text scaling, semantics, loading announcements, high contrast, and Arabic shaping on physical iOS and Android devices.
