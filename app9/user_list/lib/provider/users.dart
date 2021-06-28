import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_list/data/dummy_users.dart';
import 'package:user_list/models/user.dart';

class Users with ChangeNotifier {
  // this database is closed
  static const BASE_URL =
      "https://flutter-firebase-connect-569c7-default-rtdb.firebaseio.com/";
  final Map<String, User> _users = {...DUMMY_USERS};

  List<User> get all {
    // ao duplicar o users, evita que algum lugar fora daqui tenha acesso
    // a esses dados e possa alterar/remover a lista
    return [..._users.values];
  }

  int get count {
    return _users.length;
  }

  User byIndex(int i) {
    return _users.values.elementAt(i);
  }

  Future<void> put(User user) async {
    if (user.id.trim().isNotEmpty && _users.containsKey(user.id)) {
      await http.patch(
        Uri.parse("$BASE_URL/users/${user.id}.json"),
        body: jsonEncode({
          "name": user.name,
          "email": user.email,
          "avatarUrl": user.avatarUrl,
        }),
      );

      // update User
      _users.update(
          user.id,
          (_) => User(
                id: user.id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    } else {
      // add new User
      final response = await http.post(
        Uri.parse("$BASE_URL/users.json"),
        body: jsonEncode({
          "name": user.name,
          "email": user.email,
          "avatarUrl": user.avatarUrl,
        }),
      );

      final id = jsonDecode(response.body)["name"];
      print(jsonDecode(response.body));
      _users.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }

    // necessita chamar esse método para notificar que os dados foram alterados
    // o provider que utiliza desse ChangeNotifier irá fazer suas devidas atualizações
    // dependendo da sua implementação fora daqui
    notifyListeners();
  }

////////////////////////////////http.delete
  Future<void> remove(User user) async {
    if (user.id.trim().isNotEmpty) {
      await http.delete(
        Uri.parse("$BASE_URL/users/${user.id}.json"),
      );

      _users.remove(user.id);
      notifyListeners();
    }
  }
}
