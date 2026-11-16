import 'package:afk/app/app.dart';
import 'package:afk/design_system/components/afk_button.dart';
import 'package:afk/design_system/theme/afk_theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('switching to Arabic applies RTL directionality', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: AfkApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    final Finder welcome = find.text('مرحباً بك في AFK');
    expect(welcome, findsOneWidget);
    expect(Directionality.of(tester.element(welcome)), TextDirection.rtl);
  });

  testWidgets('AFK button invokes its callback', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: Scaffold(
          body: Center(
            child: AfkButton(
              label: 'Continue',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Continue'));
    expect(pressed, isTrue);
  });

  testWidgets('disabled AFK button does not invoke its callback', (
    WidgetTester tester,
  ) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: Scaffold(
          body: Center(child: AfkButton(label: 'Unavailable', onPressed: null)),
        ),
      ),
    );

    await tester.tap(find.text('Unavailable'));
    expect(pressed, isFalse);
  });
}
