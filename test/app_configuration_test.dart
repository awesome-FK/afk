import 'package:afk/app/app_configuration.dart';
import 'package:afk/app/app_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

AppConfiguration makeConfiguration({
  required String name,
  required String androidId,
  required String iosId,
  required AppEnvironment environment,
  required Color primaryColor,
}) {
  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  );
  final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
  );
  return AppConfiguration(
    identity: AppIdentity(
      displayName: name,
      androidApplicationId: androidId,
      iosBundleIdentifier: iosId,
    ),
    environment: environment,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  );
}

void main() {
  test('applications own independent identities, environments, and themes', () {
    final AppConfiguration alpha = makeConfiguration(
      name: 'Alpha',
      androidId: 'com.alpha.mobile',
      iosId: 'com.alpha.mobile',
      environment: AppEnvironment.staging,
      primaryColor: Colors.purple,
    );
    final AppConfiguration beta = makeConfiguration(
      name: 'Beta',
      androidId: 'io.beta.client',
      iosId: 'io.beta.client',
      environment: AppEnvironment.production,
      primaryColor: Colors.teal,
    );

    expect(alpha.identity.displayName, 'Alpha');
    expect(alpha.identity.androidApplicationId, 'com.alpha.mobile');
    expect(alpha.identity.iosBundleIdentifier, 'com.alpha.mobile');
    expect(alpha.environment, AppEnvironment.staging);
    expect(
      alpha.lightTheme.colorScheme.primary,
      isNot(beta.lightTheme.colorScheme.primary),
    );
    expect(beta.identity.displayName, 'Beta');
    expect(beta.identity.androidApplicationId, 'io.beta.client');
    expect(beta.identity.iosBundleIdentifier, 'io.beta.client');
    expect(beta.environment, AppEnvironment.production);
  });

  test('Android application IDs follow Android segment rules', () {
    for (final String valid in <String>[
      'com.example.app',
      'io.example_app.mobile2',
      'com.Example.client',
    ]) {
      expect(AppIdentity.isValidAndroidApplicationId(valid), isTrue);
    }

    for (final String invalid in <String>[
      'example',
      'com',
      '1com.example.app',
      'com.2example.app',
      'com.example-app',
      'com..example',
      '.com.example',
      'com.example.',
      'com.example.app name',
    ]) {
      expect(AppIdentity.isValidAndroidApplicationId(invalid), isFalse);
    }
  });

  test('iOS bundle identifiers follow Apple character rules', () {
    for (final String valid in <String>[
      'com.example.app',
      'com.example.mobile-app',
      'io.example2.client',
      'com.${List<String>.filled(256, 'a').join()}',
    ]) {
      expect(AppIdentity.isValidIosBundleIdentifier(valid), isTrue);
    }

    for (final String invalid in <String>[
      'example',
      'com',
      '.com.example',
      'com..example',
      'com.example.',
      'com.example_app',
      'com.example.app name',
      'com.-invalid.segment',
    ]) {
      expect(AppIdentity.isValidIosBundleIdentifier(invalid), isFalse);
    }
  });

  test(
    'configuration rejects blank names and invalid platform identifiers',
    () {
    expect(
      () => makeConfiguration(
        name: ' ',
        androidId: 'com.example.app',
        iosId: 'com.example.app',
        environment: AppEnvironment.development,
        primaryColor: Colors.black,
      ),
      throwsArgumentError,
    );
    expect(
      () => makeConfiguration(
        name: 'Example',
        androidId: 'invalid-id',
        iosId: 'com.example.app',
        environment: AppEnvironment.development,
        primaryColor: Colors.black,
      ),
      throwsArgumentError,
    );
    expect(
      () => makeConfiguration(
        name: 'Example',
        androidId: 'com.example.app',
        iosId: 'com.example_app',
        environment: AppEnvironment.development,
        primaryColor: Colors.black,
      ),
      throwsArgumentError,
    );
  });

  test(
    'separate provider containers receive app-specific storage namespaces',
    () {
    final AppConfiguration alpha = makeConfiguration(
      name: 'Alpha',
      androidId: 'com.alpha.mobile',
      iosId: 'com.alpha.mobile',
      environment: AppEnvironment.development,
      primaryColor: Colors.purple,
    );
    final AppConfiguration beta = makeConfiguration(
      name: 'Beta',
      androidId: 'com.beta.mobile',
      iosId: 'com.beta.mobile',
      environment: AppEnvironment.development,
      primaryColor: Colors.teal,
    );
    final ProviderContainer alphaContainer = ProviderContainer(
      overrides: [appConfigurationProvider.overrideWithValue(alpha)],
    );
    final ProviderContainer betaContainer = ProviderContainer(
      overrides: [appConfigurationProvider.overrideWithValue(beta)],
    );
    addTearDown(alphaContainer.dispose);
    addTearDown(betaContainer.dispose);

    final SharedPreferencesAppPreferencesRepository alphaRepository =
        alphaContainer.read(appPreferencesRepositoryProvider)
            as SharedPreferencesAppPreferencesRepository;
    final SharedPreferencesAppPreferencesRepository betaRepository =
        betaContainer.read(appPreferencesRepositoryProvider)
            as SharedPreferencesAppPreferencesRepository;

    expect(alphaRepository.storageKey, 'com.alpha.mobile.preferences.v1');
    expect(betaRepository.storageKey, 'com.beta.mobile.preferences.v1');
    expect(alphaRepository.storageKey, isNot(betaRepository.storageKey));
  });
}
