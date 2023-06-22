import 'dart:math';

import 'package:api_playground_flutter/models/todo_model.dart';
import 'package:api_playground_flutter/services/http_client_interface.dart';

class JsonPlaceholderService {
  JsonPlaceholderService(this.httpClient);

  final url = 'https://jsonplaceholder.typicode.com/todos';
  final IHttpClient httpClient;

  Future<List<TodoModel>> getTodos() async {
    final body = await httpClient.get(url);
    return (body as List).map((map) => TodoModel.fromMap(map)).toList();
  }
}
