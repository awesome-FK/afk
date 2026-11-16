import 'package:afk/app/app_preferences.dart';

class MemoryAppPreferencesRepository implements AppPreferencesRepository {
  MemoryAppPreferencesRepository({
    AppPreferences initial = const AppPreferences(),
  }) : _preferences = initial;

  AppPreferences _preferences;

  AppPreferences get value => _preferences;

  @override
  Future<AppPreferences> load() async => _preferences;

  @override
  Future<void> save(AppPreferences preferences) async {
    _preferences = preferences;
  }
}
