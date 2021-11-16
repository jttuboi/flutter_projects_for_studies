import 'dart:async';
import 'dart:core';

import 'package:todos/todos/todos.dart';

abstract class ITodosRepository {
  Future<List<TodoEntity>> loadTodos();

  Future saveTodos(List<TodoEntity> todos);
}
