import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final Provider<AppConfiguration> appConfigurationProvider =
    Provider<AppConfiguration>(
      (ref) => throw StateError(
        'AppConfiguration must be supplied by the application entry point.',
      ),
    );

enum AppEnvironment { development, staging, production }

class AppIdentity {
  const AppIdentity({
    required this.displayName,
    required this.androidApplicationId,
    required this.iosBundleIdentifier,
  });

  final String displayName;
  final String androidApplicationId;
  final String iosBundleIdentifier;

  void validate() {
    if (displayName.trim().isEmpty) {
      throw ArgumentError.value(
        displayName,
        'displayName',
        'Must not be empty.',
      );
    }
    if (!_isValidApplicationId(androidApplicationId)) {
      throw ArgumentError.value(
        androidApplicationId,
        'androidApplicationId',
      );
    }
    if (!_isValidApplicationId(iosBundleIdentifier)) {
      throw ArgumentError.value(
        iosBundleIdentifier,
        'iosBundleIdentifier',
      );
    }
  }

  static bool _isValidApplicationId(String value) => RegExp(
    r'^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)+$',
  ).hasMatch(value);
}

class AppConfiguration {
  AppConfiguration({
    required this.identity,
    required this.environment,
    required this.lightTheme,
    required this.darkTheme,
    this.showDebugBanner = false,
  }) {
    identity.validate();
  }

  final AppIdentity identity;
  final AppEnvironment environment;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final bool showDebugBanner;
}
