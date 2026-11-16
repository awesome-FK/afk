import 'package:material_ui/material_ui.dart';

import '../design_system/theme/afk_theme_colors.dart';

abstract final class ExampleAppTheme {
  static ThemeData light() => _create(Brightness.light);
  static ThemeData dark() => _create(Brightness.dark);

  static ThemeData _create(Brightness brightness) {
    const Color seedColor = Color(0xFF667085);
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    final AfkThemeColors semanticColors = AfkThemeColors(
      canvas: scheme.surface,
      surface: scheme.surface,
      surfaceRaised: scheme.surfaceContainerHighest,
      primaryText: scheme.onSurface,
      secondaryText: scheme.onSurfaceVariant,
      border: scheme.outline,
      inverseSurface: scheme.inverseSurface,
      disabled: scheme.outlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      extensions: <ThemeExtension<dynamic>>[semanticColors],
    );
  }
}
