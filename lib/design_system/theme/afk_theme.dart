import 'package:flutter/material.dart';

import '../foundations/colors/afk_colors.dart';

abstract final class AfkTheme {
  static ThemeData light() => _create(
        brightness: Brightness.light,
        canvas: AfkColors.lightCanvas,
        surface: AfkColors.lightSurface,
        text: AfkColors.lightText,
        mutedText: AfkColors.lightMutedText,
        border: AfkColors.lightBorder,
      );

  static ThemeData dark() => _create(
        brightness: Brightness.dark,
        canvas: AfkColors.darkCanvas,
        surface: AfkColors.darkSurface,
        text: AfkColors.darkText,
        mutedText: AfkColors.darkMutedText,
        border: AfkColors.darkBorder,
      );

  static ThemeData _create({
    required Brightness brightness,
    required Color canvas,
    required Color surface,
    required Color text,
    required Color mutedText,
    required Color border,
  }) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: text,
      brightness: brightness,
      surface: surface,
      error: const Color(0xFFB3261E),
    ).copyWith(
      primary: text,
      onPrimary: canvas,
      secondary: mutedText,
      onSecondary: canvas,
      onSurface: text,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvas,
      canvasColor: canvas,
      dividerColor: border,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      textTheme: Typography.material2021().black.apply(
        bodyColor: text,
        displayColor: text,
      ),
    );
  }
}
