import 'package:afk/app/app_configuration.dart';
import 'package:afk/design_system/theme/afk_theme.dart';
import 'package:flutter_test/flutter_test.dart';

AppConfiguration makeConfiguration({
  required String name,
  required String androidId,
  required String iosId,
  required AppEnvironment environment,
}) => AppConfiguration(
  identity: AppIdentity(
    displayName: name,
    androidApplicationId: androidId,
    iosBundleIdentifier: iosId,
  ),
  environment: environment,
  lightTheme: AfkTheme.light(),
  darkTheme: AfkTheme.dark(),
);

void main() {
  test('two applications can own independent identities and environments', () {
    final AppConfiguration first = makeConfiguration(
      name: 'Alpha',
      androidId: 'com.alpha.mobile',
      iosId: 'com.alpha.mobile',
      environment: AppEnvironment.staging,
    );
    final AppConfiguration second = makeConfiguration(
      name: 'Beta',
      androidId: 'io.beta.client',
      iosId: 'io.beta.client',
      environment: AppEnvironment.production,
    );

    expect(first.identity.displayName, 'Alpha');
    expect(first.identity.androidApplicationId, 'com.alpha.mobile');
    expect(first.environment, AppEnvironment.staging);
    expect(second.identity.displayName, 'Beta');
    expect(second.identity.iosBundleIdentifier, 'io.beta.client');
    expect(second.environment, AppEnvironment.production);
  });

  test('rejects blank app names and malformed native identifiers', () {
    expect(
      () => makeConfiguration(
        name: ' ',
        androidId: 'com.example.app',
        iosId: 'com.example.app',
        environment: AppEnvironment.development,
      ),
      throwsArgumentError,
    );
    expect(
      () => makeConfiguration(
        name: 'Example',
        androidId: 'bad identifier',
        iosId: 'com.example.app',
        environment: AppEnvironment.development,
      ),
      throwsArgumentError,
    );
    expect(
      () => makeConfiguration(
        name: 'Example',
        androidId: 'com.example.app',
        iosId: '.leading.dot',
        environment: AppEnvironment.development,
      ),
      throwsArgumentError,
    );
  });
}
