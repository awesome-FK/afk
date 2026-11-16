import 'package:afk/app/app_configuration.dart';
import 'package:afk/app/example_app_theme.dart';

AppConfiguration testAppConfiguration({
  String displayName = 'Test App',
  String androidApplicationId = 'com.example.testapp',
  String iosBundleIdentifier = 'com.example.testapp',
  AppEnvironment environment = AppEnvironment.development,
}) => AppConfiguration(
  identity: AppIdentity(
    displayName: displayName,
    androidApplicationId: androidApplicationId,
    iosBundleIdentifier: iosBundleIdentifier,
  ),
  environment: environment,
  lightTheme: ExampleAppTheme.light(),
  darkTheme: ExampleAppTheme.dark(),
);
