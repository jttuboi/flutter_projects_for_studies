import 'dart:convert';

import 'package:cliente/todo.dart';
import 'package:cliente/user.dart';
import 'package:http/http.dart' as http;

var loginDataSample = {
  "username": "user_a",
  "password": "123123",
  "email": "a@a.com",
};

var simulateDatabase = {
  'tokenInDatabase': '',
};

class ApiService {
  static Future<User> login(String user, String password) async {
    // https://stackoverflow.com/questions/47372568/how-to-point-to-localhost8000-with-the-dart-http-package-in-flutter
    var response = await http.post(
      Uri.parse('http://10.0.2.2:4040/api/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": user,
        "password": password,
        "email": "a@a.com",
      }),
    );

    var userConnected = User.empty();

    if (response.statusCode == 200) {
      var mapResponse = jsonDecode(response.body);
      userConnected = User.fromMap(mapResponse);
      simulateDatabase['tokenInDatabase'] = mapResponse['token'];
    }

    return userConnected;
  }

  static Future<List<Todo>> fetchTodos() async {
    var token = simulateDatabase['tokenInDatabase'];

    var response = await http.get(
      Uri.parse('http://10.0.2.2:4040/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var mapTodos = jsonDecode(response.body) as List;
      return mapTodos.map((e) => Todo.fromMap(e)).toList();
    } else {
      throw Exception;
    }
  }
}
