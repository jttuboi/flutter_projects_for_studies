import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/models/models.dart';
import 'package:todos/todos/pages/pages.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key ?? Keys.todoDetailsPage);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        final todo = (state as TodosLoadSuccess).todos.firstWhere((todo) => todo.id == id, orElse: () => Todo.empty);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Todo',
                key: Keys.deleteTodoButton,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<TodosBloc>().add(TodoDeleted(todo));
                  Navigator.pop(context, todo);
                },
              )
            ],
          ),
          body: (todo == Todo.empty)
              ? Container(key: Keys.emptyDetailsContainer)
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Checkbox(
                              key: Keys.detailsPageCheckBox,
                              value: todo.complete,
                              onChanged: (_) => context.read<TodosBloc>().add(TodoUpdated(todo.copyWith(complete: !todo.complete))),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${todo.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                                    child: Text(todo.task, key: Keys.detailsTodoItemTask, style: Theme.of(context).textTheme.headline5),
                                  ),
                                ),
                                Text(todo.note, key: Keys.detailsTodoItemNote, style: Theme.of(context).textTheme.subtitle1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: Keys.editTodoFab,
            tooltip: 'Edit Todo',
            onPressed: (todo == Todo.empty)
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return AddEditPage(
                          key: Keys.editTodoPage,
                          isEditing: true,
                          todo: todo,
                          onSave: (task, note) => context.read<TodosBloc>().add(TodoUpdated(todo.copyWith(task: task, note: note))),
                        );
                      }),
                    ),
            child: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
