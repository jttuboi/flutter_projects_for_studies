import 'package:todos_bloc/todos/todos.dart';

abstract class ITodosRepository {
  static const completeSituation = 'complete';
  static const incompleteSituation = 'incomplete';

  Future<List<Todo>> getTodos();

  Future<List<Todo>> getIncompleteTodos();

  Future<List<Todo>> getCompleteTodos();

  Future<Map<String, int>> countTodosSituation();

  Future<void> deleteTodo(Todo todo);

  Future<void> addTodo(Todo todo);

  Future<bool> hasIncomplete();

  Future<void> markAllToComplete();

  Future<void> markAllToIncomplete();

  Future<void> clearAllCompleted();

  // ignore: avoid_positional_boolean_parameters
  Future<void> checkTodo(Todo todo, bool isCompleted);
}

class TodosRepository implements ITodosRepository {
  TodosRepository({required IDatabaseService databaseService}) : _databaseService = databaseService;

  final IDatabaseService _databaseService;

  @override
  Future<List<Todo>> getTodos() async {
    return _databaseService.getTodos();
  }

  @override
  Future<List<Todo>> getIncompleteTodos() async {
    return _databaseService.getIncompleteTodos();
  }

  @override
  Future<List<Todo>> getCompleteTodos() async {
    return _databaseService.getCompleteTodos();
  }

  @override
  Future<Map<String, int>> countTodosSituation() async {
    final todos = await _databaseService.getTodos();

    var completeQuantity = 0;
    var incompleteQuantity = 0;

    for (final todo in todos) {
      if (todo.completed) {
        completeQuantity++;
      } else {
        incompleteQuantity++;
      }
    }

    return {
      ITodosRepository.completeSituation: completeQuantity,
      ITodosRepository.incompleteSituation: incompleteQuantity,
    };
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _databaseService.deleteTodo(todo);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await _databaseService.saveTodo(todo.copyWith(completed: false));
  }

  @override
  Future<bool> hasIncomplete() async {
    final todos = await _databaseService.getTodos();
    return todos.fold<bool>(false, (previousValue, todo) => previousValue || !todo.completed);
  }

  @override
  Future<void> markAllToComplete() async {
    await _databaseService.markAllTodos(completed: true);
  }

  @override
  Future<void> markAllToIncomplete() async {
    await _databaseService.markAllTodos(completed: false);
  }

  @override
  Future<void> clearAllCompleted() async {
    await _databaseService.clearAllCompleted();
  }

  @override
  Future<void> checkTodo(Todo todo, bool isCompleted) async {
    await _databaseService.checkTodo(todo, isCompleted);
  }
}
