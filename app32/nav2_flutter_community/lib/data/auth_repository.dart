import 'package:nav2_flutter_community/common/cache/preference.dart';

const String _AUTH_KEY = 'AuthKey';

class AuthRepository {
  AuthRepository(this.preference);

  final Preference preference;

  Future<bool> isUserLoggedIn() async {
    return Future.delayed(Duration(seconds: 2)).then((value) {
      return preference.getBool(_AUTH_KEY, defaultValue: false);
    });
  }

  Future<bool> _updateLoginStatus(bool loggedIn) {
    return Future.delayed(Duration(seconds: 2)).then((value) {
      return preference.putBool(_AUTH_KEY, loggedIn);
    });
  }

  Future<bool> logout() => _updateLoginStatus(false);

  Future<bool> login() => _updateLoginStatus(true);
}
