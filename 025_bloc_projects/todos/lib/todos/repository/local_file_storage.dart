import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:todos/todos/repository/repository.dart';

class FileStorage implements ITodosRepository {
  const FileStorage(
    this.tag,
    this.getDirectory, // o metodo getDirectory permite testar sem tem problema de integração com o OS filesystem
  );

  final String tag;
  final Future<Directory> Function() getDirectory;

  @override
  Future<List<TodoEntity>> loadTodos() async {
    var todos = <TodoEntity>[];

    final file = await _getLocalFile();
    if (file.existsSync()) {
      final string = await file.readAsString();
      final json = jsonDecode(string);
      todos = (json['todos']).map<TodoEntity>((json) => TodoEntity.fromMap(json)).toList();
    }

    return todos;
  }

  @override
  Future<File> saveTodos(List<TodoEntity> todos) async {
    final file = await _getLocalFile();

    return file.writeAsString(jsonEncode({
      'todos': todos.map((todo) => todo.toJson()).toList(),
    }));
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();
    return file.delete();
  }

  // acesso local do celular (NO API)
  Future<File> _getLocalFile() async {
    final dir = await getDirectory();
    return File('${dir.path}/TodosStorage__$tag.json');
  }
}
