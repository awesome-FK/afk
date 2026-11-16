import 'package:flutter/material.dart';

abstract final class AfkTypography {
  static TextTheme create({required Color primary, required Color secondary}) {
    final TextTheme base = Typography.material2021().black;
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: primary,
        fontSize: 56,
        height: 1.08,
        fontWeight: FontWeight.w600,
        letterSpacing: -2.2,
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: primary,
        fontSize: 44,
        height: 1.12,
        fontWeight: FontWeight.w600,
        letterSpacing: -1.6,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: primary,
        fontSize: 32,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.9,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: primary,
        fontSize: 28,
        height: 1.25,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.6,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: primary,
        fontSize: 22,
        height: 1.3,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: primary,
        fontSize: 16,
        height: 1.4,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: primary,
        fontSize: 16,
        height: 1.55,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: primary,
        fontSize: 14,
        height: 1.5,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: secondary,
        fontSize: 12,
        height: 1.45,
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: primary,
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: primary,
        fontSize: 12,
        height: 1.3,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: secondary,
        fontSize: 10,
        height: 1.3,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
