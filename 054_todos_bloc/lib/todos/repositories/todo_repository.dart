import 'package:todos_bloc/todos/todos.dart';

abstract class ITodoRepository {
  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  // ignore: avoid_positional_boolean_parameters
  Future<void> checkTodo(Todo todo, bool isCompleted);
}

class TodoRepository implements ITodoRepository {
  TodoRepository({required IDatabaseService databaseService}) : _databaseService = databaseService;

  final IDatabaseService _databaseService;

  @override
  Future<void> saveTodo(Todo todo) async {
    await _databaseService.saveTodo(todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _databaseService.deleteTodo(todo);
  }

  @override
  Future<void> checkTodo(Todo todo, bool isCompleted) async {
    await _databaseService.checkTodo(todo, isCompleted);
  }
}
