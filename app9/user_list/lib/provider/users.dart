import 'dart:math';

import 'package:flutter/material.dart';
import 'package:user_list/data/dummy_users.dart';
import 'package:user_list/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _users = {...DUMMY_USERS};

  List<User> get all {
    // ao duplicar o users, evita que algum lugar fora daqui tenha acesso
    // a esses dados e possa alterar/remover
    return [..._users.values];
  }

  int get count {
    return _users.length;
  }

  User byIndex(int i) {
    return _users.values.elementAt(i);
  }

  void put(User user) {
    final id = Random().nextDouble().toString();
    _users.putIfAbsent(
      id,
      () => User(
        id: id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ),
    );

    // necessita chamar esse método para notificar que os dados foram alterados
    // o provider que utiliza desse ChangeNotifier irá fazer suas devidas atualizações
    // dependendo da sua implementação fora daqui
    notifyListeners();
  }
}
