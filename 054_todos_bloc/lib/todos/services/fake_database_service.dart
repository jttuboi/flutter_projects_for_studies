import 'package:todos_bloc/todos/todos.dart';
import 'package:uuid/uuid.dart';

class FakeDatabaseService implements IDatabaseService {
  List<Todo> _todos = [
    Todo(id: const Uuid().v4(), title: 'lavar louça', subtitle: 'não esquecer de guarda-los', completed: true),
    Todo(id: const Uuid().v4(), title: 'lavar louça 2', subtitle: 'não esquecer de guarda-los 2', completed: true),
    Todo(id: const Uuid().v4(), title: 'estudar bloc', subtitle: 'não esquecer de testar', completed: false),
    Todo(id: const Uuid().v4(), title: 'estudar bloc 2', subtitle: 'não esquecer de testar 2', completed: false),
  ];

  @override
  Future<List<Todo>> getTodos() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_todos);
  }

  @override
  Future<List<Todo>> getIncompleteTodos() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _todos.where((todo) => !todo.completed).toList();
  }

  @override
  Future<List<Todo>> getCompleteTodos() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _todos.where((todo) => todo.completed).toList();
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _todos.remove(todo);
  }

  @override
  Future<void> markAllTodos({required bool completed}) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final newTodos = <Todo>[];
    for (final todo in _todos) {
      newTodos.add(todo.copyWith(completed: completed));
    }
    _todos = newTodos;
  }

  @override
  Future<void> clearAllCompleted() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _todos.removeWhere((todo) => todo.completed);
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (todo.id.isEmpty) {
      _todos.add(todo.copyWith(id: const Uuid().v4()));
    } else {
      _todos
        ..removeWhere((pTodo) => todo.id == pTodo.id)
        ..add(todo);
    }
  }

  @override
  Future<void> checkTodo(Todo todo, bool isCompleted) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _todos
      ..removeWhere((pTodo) => todo.id == pTodo.id)
      ..add(todo.copyWith(completed: isCompleted));
  }
}
