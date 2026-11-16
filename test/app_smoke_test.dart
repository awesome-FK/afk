import 'package:afk/app/app.dart';
import 'package:afk/app/app_configuration.dart';
import 'package:afk/app/app_preferences.dart';
import 'package:afk/design_system/theme/afk_theme_colors.dart';
import 'package:afk/localization/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'support/memory_app_preferences_repository.dart';
import 'support/test_app_configuration.dart';

ThemeData createAppTheme(Color seedColor, Brightness brightness) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: scheme,
    extensions: <ThemeExtension<dynamic>>[
      AfkThemeColors(
        canvas: scheme.surface,
        surface: scheme.surface,
        surfaceRaised: scheme.surfaceContainerHighest,
        primaryText: scheme.onSurface,
        secondaryText: scheme.onSurfaceVariant,
        border: scheme.outline,
        inverseSurface: scheme.inverseSurface,
        disabled: Colors.grey,
      ),
    ],
  );
}

void main() {
  testWidgets('renders the configured app identity in English by default', (
    WidgetTester tester,
  ) async {
    final MemoryAppPreferencesRepository repository =
        MemoryAppPreferencesRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesRepositoryProvider.overrideWithValue(repository),
          appConfigurationProvider.overrideWithValue(testAppConfiguration()),
        ],
        child: const AppRoot(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Test App'), findsOneWidget);
    expect(find.text('Welcome to Test App'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
  });

  testWidgets('applies configured identity and visual theme to the app root', (
    WidgetTester tester,
  ) async {
    final ThemeData lightTheme = createAppTheme(
      Colors.purple,
      Brightness.light,
    );
    final AppConfiguration configuration = AppConfiguration(
      identity: const AppIdentity(
        displayName: 'Independent App',
        androidApplicationId: 'com.independent.app',
        iosBundleIdentifier: 'com.independent.app',
      ),
      environment: AppEnvironment.production,
      lightTheme: lightTheme,
      darkTheme: createAppTheme(Colors.teal, Brightness.dark),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesRepositoryProvider.overrideWithValue(
            MemoryAppPreferencesRepository(),
          ),
          appConfigurationProvider.overrideWithValue(configuration),
        ],
        child: const AppRoot(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Independent App'), findsOneWidget);
    expect(find.text('Welcome to Independent App'), findsOneWidget);
    final Finder welcome = find.text('Welcome to Independent App');
    expect(
      Theme.of(tester.element(welcome)).colorScheme.primary,
      lightTheme.colorScheme.primary,
    );
  });

  test('supports English and Arabic locales', () {
    expect(
      AppLocalizations.supportedLocales.map((locale) => locale.languageCode),
      containsAll(<String>['en', 'ar']),
    );
  });
}
