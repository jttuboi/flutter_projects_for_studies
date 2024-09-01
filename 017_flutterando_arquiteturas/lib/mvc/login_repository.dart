import 'package:flutterando_arquiteturas/mvc/user_model.dart';

class LoginRepository {
  Future<bool> doLogin(UserModel model) async {
    // simula a conexão do app com o servidor via API
    await Future.delayed(Duration(seconds: 2));
    return model.email == 'a@a.com' && model.password == 'a';
  }
}
