import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/blocs/simple_bloc_observer.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/models/models.dart';
import 'package:todos/todos/pages/pages.dart';
import 'package:todos/todos/repository/repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  const _fileStorage = FileStorage('__flutter_bloc_app__', getApplicationDocumentsDirectory);
  runApp(
    BlocProvider(
      create: (context) => TodosBloc(todosRepository: TodosRepository(fileStorage: _fileStorage))..add(TodosLoaded()),
      child: const TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  const TodosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.theme,
      routes: {
        Routes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(create: (context) => TabBloc()),
              BlocProvider<FilteredTodosBloc>(create: (context) => FilteredTodosBloc(todosBloc: BlocProvider.of<TodosBloc>(context))),
              BlocProvider<StatsBloc>(create: (context) => StatsBloc(todosBloc: BlocProvider.of<TodosBloc>(context))),
            ],
            child: const HomePage(),
          );
        },
        Routes.addTodo: (context) {
          return AddEditPage(
            key: Keys.addTodoPage,
            onSave: (task, note) => context.read<TodosBloc>().add(TodoAdded(Todo(task, note: note))),
            isEditing: false,
          );
        },
      },
    );
  }
}
