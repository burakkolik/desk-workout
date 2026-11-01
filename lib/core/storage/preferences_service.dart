import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences so storage can be swapped easily.
class PreferencesService {
  PreferencesService._(this._prefs);

  final SharedPreferences _prefs;

  static Future<PreferencesService> create() async => PreferencesService._(await SharedPreferences.getInstance());

  String? getString(String key) => _prefs.getString(key);
  int? getInt(String key) => _prefs.getInt(key);
  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> setString(String key, String? value) =>
      value == null ? _prefs.remove(key) : _prefs.setString(key, value);
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);
  Future<void> remove(String key) => _prefs.remove(key);
}
