import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../design_system/theme/afk_theme.dart';
import '../localization/app_localizations.dart';
import '../routing/app_router.dart';
import 'app_preferences.dart';

class AfkApp extends ConsumerWidget {
  const AfkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppPreferences preferences = ref.watch(appPreferencesProvider).when(
          data: (AppPreferences value) => value,
          error: (Object error, StackTrace stackTrace) =>
              const AppPreferences(),
          loading: () => const AppPreferences(),
        );
    final GoRouter router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'AFK',
      debugShowCheckedModeBanner: false,
      theme: AfkTheme.light(),
      darkTheme: AfkTheme.dark(),
      themeMode: preferences.themeMode,
      locale: preferences.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      routerConfig: router,
    );
  }
}
