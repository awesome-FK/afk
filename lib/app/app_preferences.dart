import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class AppPreferences {
  const AppPreferences({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
  });

  final ThemeMode themeMode;
  final Locale locale;

  AppPreferences copyWith({ThemeMode? themeMode, Locale? locale}) =>
      AppPreferences(
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this.locale,
      );
}

abstract interface class AppPreferencesRepository {
  Future<AppPreferences> load();
  Future<void> save(AppPreferences preferences);
}

class SharedPreferencesAppPreferencesRepository
    implements AppPreferencesRepository {
  SharedPreferencesAppPreferencesRepository(this._storage);

  static const String _storageKey = 'afk.app_preferences.v1';

  final SharedPreferencesAsync _storage;

  @override
  Future<AppPreferences> load() async {
    final String? encoded = await _storage.getString(_storageKey);
    if (encoded == null) return const AppPreferences();

    final Object? decoded = jsonDecode(encoded);
    if (decoded is! Map<String, Object?>) return const AppPreferences();

    return AppPreferences(
      themeMode: _themeModeFrom(decoded['themeMode']),
      locale: _localeFrom(decoded['locale']),
    );
  }

  @override
  Future<void> save(AppPreferences preferences) async {
    final String encoded = jsonEncode(<String, String>{
      'themeMode': preferences.themeMode.name,
      'locale': preferences.locale.languageCode,
    });
    await _storage.setString(_storageKey, encoded);
  }

  ThemeMode _themeModeFrom(Object? value) => switch (value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  Locale _localeFrom(Object? value) =>
      value == 'ar' ? const Locale('ar') : const Locale('en');
}

final Provider<AppPreferencesRepository> appPreferencesRepositoryProvider =
    Provider<AppPreferencesRepository>(
  (ref) => SharedPreferencesAppPreferencesRepository(SharedPreferencesAsync()),
);

final AsyncNotifierProvider<AppPreferencesController, AppPreferences>
    appPreferencesProvider =
    AsyncNotifierProvider<AppPreferencesController, AppPreferences>(
  AppPreferencesController.new,
);

class AppPreferencesController extends AsyncNotifier<AppPreferences> {
  AppPreferences _current = const AppPreferences();
  Future<void> _writeQueue = Future<void>.value();

  @override
  Future<AppPreferences> build() async {
    try {
      _current = await ref.watch(appPreferencesRepositoryProvider).load();
    } catch (error, stackTrace) {
      _report(error, stackTrace, 'load');
      _current = const AppPreferences();
    }
    return _current;
  }

  Future<void> setThemeMode(ThemeMode mode) =>
      _update(_current.copyWith(themeMode: mode));

  Future<void> setLocale(Locale locale) {
    if (locale.languageCode != 'en' && locale.languageCode != 'ar') {
      throw ArgumentError.value(locale, 'locale', 'Unsupported AFK locale.');
    }
    return _update(_current.copyWith(locale: locale));
  }

  Future<void> _update(AppPreferences next) {
    _current = next;
    state = AsyncData<AppPreferences>(next);

    final AppPreferencesRepository repository =
        ref.read(appPreferencesRepositoryProvider);
    _writeQueue = _writeQueue.then<void>((_) async {
      try {
        await repository.save(next);
      } catch (error, stackTrace) {
        _report(error, stackTrace, 'save');
      }
    });
    return _writeQueue;
  }

  void _report(Object error, StackTrace stackTrace, String operation) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'AFK app preferences',
        context: ErrorDescription('Unable to $operation app preferences.'),
      ),
    );
  }
}
