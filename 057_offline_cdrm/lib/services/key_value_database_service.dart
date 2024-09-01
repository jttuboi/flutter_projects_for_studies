import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IKeyValueDatabaseService {
  Future<void> putString(String key, {required String value});

  Future<String> getString(String key);
}

class SharedPreferencesService implements IKeyValueDatabaseService {
  const SharedPreferencesService();

  @override
  Future<void> putString(String key, {required String value}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(key, value);
  }

  @override
  Future<String> getString(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(key) ?? '';
  }
}
