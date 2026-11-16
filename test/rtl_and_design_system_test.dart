import 'package:afk/app/app.dart';
import 'package:afk/app/app_preferences.dart';
import 'package:afk/design_system/components/afk_button.dart';
import 'package:afk/design_system/theme/afk_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'support/memory_app_preferences_repository.dart';

void main() {
  testWidgets('switching to Arabic applies RTL directionality', (
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

    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    final Finder welcome = find.text('مرحباً بك في AFK');
    expect(welcome, findsOneWidget);
    expect(Directionality.of(tester.element(welcome)), TextDirection.rtl);
  });

  testWidgets('restores saved theme and locale preferences', (
    WidgetTester tester,
  ) async {
    final MemoryAppPreferencesRepository repository =
        MemoryAppPreferencesRepository(
          initial: const AppPreferences(
            themeMode: ThemeMode.dark,
            locale: Locale('ar'),
          ),
        );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesRepositoryProvider.overrideWithValue(repository),
        ],
        child: const AfkApp(),
      ),
    );
    await tester.pumpAndSettle();

    final Finder welcome = find.text('مرحباً بك في AFK');
    expect(welcome, findsOneWidget);
    expect(Theme.of(tester.element(welcome)).brightness, Brightness.dark);
  });

  testWidgets('AFK button invokes its callback', (WidgetTester tester) async {
    final List<bool> pressed = <bool>[false];

    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: Scaffold(
          body: Center(
            child: AfkButton(
              label: 'Continue',
              onPressed: () => pressed[0] = true,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Continue'));
    expect(pressed.single, isTrue);
  });

  testWidgets('disabled AFK button does not invoke its callback', (
    WidgetTester tester,
  ) async {
    final List<bool> pressed = <bool>[false];

    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: Scaffold(
          body: Center(child: AfkButton(label: 'Unavailable', onPressed: null)),
        ),
      ),
    );

    await tester.tap(find.text('Unavailable'));
    expect(pressed.single, isFalse);
  });
}
