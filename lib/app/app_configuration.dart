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
    if (!isValidAndroidApplicationId(androidApplicationId)) {
      throw ArgumentError.value(
        androidApplicationId,
        'androidApplicationId',
        'Must contain at least two dot-separated segments. Each segment must '
            'start with a letter and contain only letters, numbers, or '
            'underscores.',
      );
    }
    if (!isValidIosBundleIdentifier(iosBundleIdentifier)) {
      throw ArgumentError.value(
        iosBundleIdentifier,
        'iosBundleIdentifier',
        'Must contain at least two dot-separated segments. Each segment must '
            'start with a letter or number and contain only letters, numbers, '
            'or hyphens. Maximum length is 255 characters.',
      );
    }
  }

  static bool isValidAndroidApplicationId(String value) =>
      RegExp(
    r'^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)+$',
  ).hasMatch(value);

  static bool isValidIosBundleIdentifier(String value) =>
      value.length <= 255 &&
      RegExp(
        r'^[A-Za-z0-9][A-Za-z0-9-]*(\.[A-Za-z0-9][A-Za-z0-9-]*)+$',
      )
      .hasMatch(value);
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
