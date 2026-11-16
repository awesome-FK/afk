import 'package:flutter/material.dart';

@immutable
class AfkThemeColors extends ThemeExtension<AfkThemeColors> {
  const AfkThemeColors({
    required this.canvas,
    required this.surface,
    required this.surfaceRaised,
    required this.primaryText,
    required this.secondaryText,
    required this.border,
    required this.inverseSurface,
    required this.disabled,
  });

  final Color canvas;
  final Color surface;
  final Color surfaceRaised;
  final Color primaryText;
  final Color secondaryText;
  final Color border;
  final Color inverseSurface;
  final Color disabled;

  static AfkThemeColors of(BuildContext context) {
    final AfkThemeColors? colors = Theme.of(context)
        .extension<AfkThemeColors>();
    assert(colors != null, 'AfkThemeColors must be registered in AfkTheme.');
    return colors!;
  }

  @override
  AfkThemeColors copyWith({
    Color? canvas,
    Color? surface,
    Color? surfaceRaised,
    Color? primaryText,
    Color? secondaryText,
    Color? border,
    Color? inverseSurface,
    Color? disabled,
  }) => AfkThemeColors(
    canvas: canvas ?? this.canvas,
    surface: surface ?? this.surface,
    surfaceRaised: surfaceRaised ?? this.surfaceRaised,
    primaryText: primaryText ?? this.primaryText,
    secondaryText: secondaryText ?? this.secondaryText,
    border: border ?? this.border,
    inverseSurface: inverseSurface ?? this.inverseSurface,
    disabled: disabled ?? this.disabled,
  );

  @override
  AfkThemeColors lerp(ThemeExtension<AfkThemeColors>? other, double t) {
    if (other is! AfkThemeColors) return this;
    return AfkThemeColors(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      border: Color.lerp(border, other.border, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
    );
  }
}
