import 'package:afk/app/app.dart';
import 'package:afk/app/app_preferences.dart';
import 'package:afk/localization/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/memory_app_preferences_repository.dart';

void main() {
  testWidgets('renders the AFK foundation in English by default', (
    WidgetTester tester,
  ) async {
    final MemoryAppPreferencesRepository repository =
        MemoryAppPreferencesRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesRepositoryProvider.overrideWithValue(repository),
        ],
        child: const AfkApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('AFK'), findsOneWidget);
    expect(find.text('Welcome to AFK'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
  });

  test('supports English and Arabic locales', () {
    expect(
      AppLocalizations.supportedLocales.map((locale) => locale.languageCode),
      containsAll(<String>['en', 'ar']),
    );
  });
}
