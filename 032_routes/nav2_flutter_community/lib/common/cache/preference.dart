import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Preference._();

  static final Preference _instance = Preference._();

  factory Preference() {
    return _instance;
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getString(String key, {required String defaultValue}) async {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString(key) ?? defaultValue;
    });
  }

  putString(String key, String value) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString(key, value);
    });
  }

  Future<bool> getBool(String key, {required bool defaultValue}) async {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(key) ?? defaultValue;
    });
  }

  /// Puts bool [value] and returns true if the operation is success.
  Future<bool> putBool(String key, bool value) async {
    return _prefs.then((SharedPreferences prefs) {
      prefs.setBool(key, value);
      return true;
    });
  }
}
