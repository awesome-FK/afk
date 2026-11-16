import 'package:afk/app/app.dart';
import 'package:afk/app/app_configuration.dart';
import 'package:afk/app/app_preferences.dart';
import 'package:afk/localization/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'support/memory_app_preferences_repository.dart';
import 'support/test_app_configuration.dart';

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
    final AppConfiguration configuration = AppConfiguration(
      identity: const AppIdentity(
        displayName: 'Independent App',
        androidApplicationId: 'com.independent.app',
        iosBundleIdentifier: 'com.independent.app',
      ),
      environment: AppEnvironment.production,
      lightTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
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
      Colors.purple,
    );
  });

  test('supports English and Arabic locales', () {
    expect(
      AppLocalizations.supportedLocales.map((locale) => locale.languageCode),
      containsAll(<String>['en', 'ar']),
    );
  });
}
