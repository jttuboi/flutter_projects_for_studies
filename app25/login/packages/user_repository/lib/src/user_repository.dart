import 'dart:async';
import 'package:uuid/uuid.dart';
import 'models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    // retorna os dados do usuario logado
    if (_user != null) {
      return _user;
    }

    // simula o acesso ao banco de dados do servidor
    return Future.delayed(
      const Duration(milliseconds: 300),
      // dados do novo usuario
      () => _user = User(const Uuid().v4()),
    );
  }
}
