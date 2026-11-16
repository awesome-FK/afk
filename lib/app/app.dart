import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../localization/app_localizations.dart';
import '../routing/app_router.dart';
import 'app_configuration.dart';
import 'app_preferences.dart';

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppConfiguration configuration = ref.watch(appConfigurationProvider);
    final AppPreferences preferences = ref
        .watch(appPreferencesProvider)
        .when(
          data: (AppPreferences value) => value,
          error: (Object error, StackTrace stackTrace) =>
              const AppPreferences(),
          loading: () => const AppPreferences(),
        );
    final GoRouter router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: configuration.identity.displayName,
      debugShowCheckedModeBanner: configuration.showDebugBanner,
      theme: configuration.lightTheme,
      darkTheme: configuration.darkTheme,
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
