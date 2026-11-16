import '../design_system/theme/afk_theme.dart';
import 'app_configuration.dart';

final AppConfiguration afkExampleConfiguration = AppConfiguration(
  identity: const AppIdentity(
    displayName: 'AFK',
    androidApplicationId: 'dev.awesomefk.afk',
    iosBundleIdentifier: 'dev.awesomefk.afk',
  ),
  environment: AppEnvironment.development,
  lightTheme: AfkTheme.light(),
  darkTheme: AfkTheme.dark(),
  showDebugBanner: true,
);
