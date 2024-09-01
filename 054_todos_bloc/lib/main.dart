import 'package:flutter/material.dart';
import 'package:todos_bloc/todos/services/fake_database_service.dart';
import 'package:todos_bloc/todos/todos.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _databaseService = FakeDatabaseService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      onGenerateRoute: (settings) {
        if (settings.name == TodosPage.routeName) {
          return TodosPage.route(todosRepository: TodosRepository(databaseService: _databaseService));
        }
        if (settings.name == TodoDetailPage.routeName) {
          return TodoDetailPage.route(
            todoRepository: TodoRepository(databaseService: _databaseService),
            todo: settings.arguments == null ? Todo.empty : settings.arguments! as Todo,
          );
        }
        if (settings.name == TodoFormPage.routeName) {
          return TodoFormPage.route(
            onSaved: (settings.arguments! as Map<String, dynamic>)['onSaved'] as Function(Todo todo),
            todo: (settings.arguments! as Map<String, dynamic>).containsKey('todo')
                ? (settings.arguments! as Map<String, dynamic>)['todo'] as Todo
                : Todo.empty,
          );
        }
      },
    );
  }
}
