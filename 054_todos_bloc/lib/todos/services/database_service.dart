import 'package:todos_bloc/todos/todos.dart';

abstract class IDatabaseService {
  Future<List<Todo>> getTodos();

  Future<List<Todo>> getIncompleteTodos();

  Future<List<Todo>> getCompleteTodos();

  Future<void> deleteTodo(Todo todo);

  Future<void> markAllTodos({required bool completed});

  Future<void> clearAllCompleted();

  Future<void> saveTodo(Todo todo);

  // ignore: avoid_positional_boolean_parameters
  Future<void> checkTodo(Todo todo, bool isCompleted);
}
