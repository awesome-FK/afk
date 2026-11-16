import 'package:material_ui/material_ui.dart';

import '../foundations/colors/afk_colors.dart';
import '../foundations/typography/afk_typography.dart';
import 'afk_theme_colors.dart';

abstract final class AfkTheme {
  static ThemeData light() => _create(
    brightness: Brightness.light,
    canvas: AfkColors.lightCanvas,
    surface: AfkColors.lightSurface,
    raisedSurface: AfkColors.neutral100,
    text: AfkColors.lightText,
    mutedText: AfkColors.lightMutedText,
    border: AfkColors.lightBorder,
    inverseSurface: AfkColors.neutral900,
    disabled: AfkColors.neutral400,
  );

  static ThemeData dark() => _create(
    brightness: Brightness.dark,
    canvas: AfkColors.darkCanvas,
    surface: AfkColors.darkSurface,
    raisedSurface: AfkColors.neutral900,
    text: AfkColors.darkText,
    mutedText: AfkColors.darkMutedText,
    border: AfkColors.darkBorder,
    inverseSurface: AfkColors.neutral100,
    disabled: AfkColors.neutral600,
  );

  static ThemeData _create({
    required Brightness brightness,
    required Color canvas,
    required Color surface,
    required Color raisedSurface,
    required Color text,
    required Color mutedText,
    required Color border,
    required Color inverseSurface,
    required Color disabled,
  }) {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(
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

    final AfkThemeColors afkColors = AfkThemeColors(
      canvas: canvas,
      surface: surface,
      surfaceRaised: raisedSurface,
      primaryText: text,
      secondaryText: mutedText,
      border: border,
      inverseSurface: inverseSurface,
      disabled: disabled,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'AfkPlexArabic',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvas,
      canvasColor: canvas,
      dividerColor: border,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      extensions: <ThemeExtension<dynamic>>[afkColors],
      textTheme: AfkTypography.create(primary: text, secondary: mutedText),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: mutedText),
        errorStyle: const TextStyle(fontSize: 12, height: 1.35),
      ),
    );
  }
}
