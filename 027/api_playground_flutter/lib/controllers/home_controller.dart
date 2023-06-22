import 'package:api_playground_flutter/models/todo_model.dart';
import 'package:api_playground_flutter/services/json_placeholder_service.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.service);

  final JsonPlaceholderService service;
  var todos = <TodoModel>[];

  Future<void> fetchAllTodos() async {
    todos = await service.getTodos();
    notifyListeners();
  }
}
