import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/todos/todos.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage._({required ITodoRepository todoRepository, required Todo todo, Key? key})
      : _todoRepository = todoRepository,
        _todo = todo,
        super(key: key);

  static const routeName = '/todo_detail';
  static Route route({required ITodoRepository todoRepository, required Todo todo}) {
    return MaterialPageRoute(builder: (context) => TodoDetailPage._(todoRepository: todoRepository, todo: todo));
  }

  final ITodoRepository _todoRepository;
  final Todo _todo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(todoRepository: _todoRepository, todo: _todo),
      child: const TodoDetailView(),
    );
  }
}

class TodoDetailView extends StatefulWidget {
  const TodoDetailView({Key? key}) : super(key: key);

  @override
  State<TodoDetailView> createState() => _TodoDetailViewState();
}

class _TodoDetailViewState extends State<TodoDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TodoBloc>().add(TodoDeleted());
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Hero(
        tag: context.watch<TodoBloc>().state.todo.id,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: context.watch<TodoBloc>().state.todo.completed,
                onChanged: (value) => context.read<TodoBloc>().add(TodoChecked(isCompleted: value!)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Text(context.watch<TodoBloc>().state.todo.title, style: const TextStyle(fontSize: 24)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(context.watch<TodoBloc>().state.todo.subtitle, style: const TextStyle(fontSize: 20)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, TodoFormPage.routeName, arguments: {
            'todo': context.read<TodoBloc>().state.todo,
            'onSaved': (todo) {
              Navigator.pop(context);
              context.read<TodoBloc>().add(TodoSaved(todo: todo as Todo));
            },
          });
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
