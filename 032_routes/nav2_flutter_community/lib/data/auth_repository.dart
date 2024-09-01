import 'package:nav2_flutter_community/common/cache/preference.dart';

const String _AUTH_KEY = 'AuthKey';

class AuthRepository {
  AuthRepository(this.preference);

  final Preference preference;

  Future<bool> isUserLoggedIn() async {
    return Future.delayed(Duration(seconds: 2)).then((value) {
      // passa uma authentication key para o "servidor"
      // e o servidor responde se o usuário está logado ou não
      return preference.getBool(_AUTH_KEY, defaultValue: false);
    });
  }

  Future<bool> login() => _updateLoginStatus(true);

  Future<bool> logout() => _updateLoginStatus(false);

  Future<bool> _updateLoginStatus(bool loggedIn) {
    return Future.delayed(Duration(seconds: 2)).then((value) {
      // quando loga, ele simula que o usuario recebeu um key dizendo que está logado
      // quando desloga, ele simula que o usuario nao tem mais a key dizendo que está deslogado
      return preference.putBool(_AUTH_KEY, loggedIn);
    });
  }
}
