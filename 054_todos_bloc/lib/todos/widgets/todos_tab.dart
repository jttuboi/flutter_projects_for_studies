import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/todos/todos.dart';

class TodosTab extends StatelessWidget {
  const TodosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _todos = context.watch<TodosBloc>().state.todos;
    return ListView.builder(
      itemBuilder: (_, index) {
        return TodoTile(
          todo: _todos[index],
          onChecked: (completed) => context.read<TodosBloc>().add(TodoCheckedFromList(todo: _todos[index], isCompleted: completed)),
          onDelete: (todoDeleted) => context.read<TodosBloc>().add(TodoDeletedFromList(todo: _todos[index])),
          onUndo: () => context.read<TodosBloc>().add(TodoUndone()),
          onBackEdit: () => context.read<TodosBloc>().add(TodosUpdated()),
        );
      },
      itemCount: _todos.length,
    );
  }
}
