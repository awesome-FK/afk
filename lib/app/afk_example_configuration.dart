import 'app_configuration.dart';
import 'example_app_theme.dart';

final AppConfiguration exampleAppConfiguration = AppConfiguration(
  identity: const AppIdentity(
    displayName: 'Example App',
    androidApplicationId: 'com.example.app',
    iosBundleIdentifier: 'com.example.app',
  ),
  environment: AppEnvironment.development,
  lightTheme: ExampleAppTheme.light(),
  darkTheme: ExampleAppTheme.dark(),
  showDebugBanner: true,
);
