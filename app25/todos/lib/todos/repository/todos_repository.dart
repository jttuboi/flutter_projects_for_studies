import 'package:todos/todos/repository/repository.dart';

class TodosRepository implements ITodosRepository {
  TodosRepository({required this.fileStorage});

  final FileStorage fileStorage;

  @override
  Future<List<TodoEntity>> loadTodos() async {
    return fileStorage.loadTodos();
  }

  @override
  Future saveTodos(List<TodoEntity> todos) async {
    await fileStorage.saveTodos(todos);
  }
}
