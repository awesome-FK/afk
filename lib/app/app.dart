import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../design_system/theme/afk_theme.dart';
import '../localization/app_localizations.dart';
import '../routing/app_router.dart';
import 'app_preferences.dart';

class AfkApp extends ConsumerWidget {
  const AfkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final Locale locale = ref.watch(localeProvider);
    final GoRouter router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'AFK',
      debugShowCheckedModeBanner: false,
      theme: AfkTheme.light(),
      darkTheme: AfkTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      routerConfig: router,
    );
  }
}
