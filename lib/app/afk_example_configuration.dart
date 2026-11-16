import '../design_system/theme/afk_theme.dart';
import 'app_configuration.dart';

final AppConfiguration exampleAppConfiguration = AppConfiguration(
  identity: const AppIdentity(
    displayName: 'Example App',
    androidApplicationId: 'com.example.app',
    iosBundleIdentifier: 'com.example.app',
  ),
  environment: AppEnvironment.development,
  lightTheme: AfkTheme.light(),
  darkTheme: AfkTheme.dark(),
  showDebugBanner: true,
);
