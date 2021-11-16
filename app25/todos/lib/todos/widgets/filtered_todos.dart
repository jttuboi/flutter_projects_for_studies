import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/pages/pages.dart';
import 'package:todos/todos/widgets/widgets.dart';

class FilteredTodos extends StatelessWidget {
  const FilteredTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoadInProgress) {
          return const LoadingIndicator(key: Keys.todosLoading);
        } else if (state is FilteredTodosLoadSuccess) {
          final todos = state.filteredTodos;
          return ListView.builder(
            key: Keys.todoList,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  context.read<TodosBloc>().add(TodoDeleted(todo));
                  ScaffoldMessenger.of(context).showSnackBar(
                    DeleteTodoSnackBar(
                      key: Keys.snackbar,
                      todo: todo,
                      onUndo: () => context.read<TodosBloc>().add(TodoAdded(todo)),
                    ),
                  );
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => DetailsPage(id: todo.id)),
                  );
                  if (removedTodo != null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        key: Keys.snackbar,
                        todo: todo,
                        onUndo: () => context.read<TodosBloc>().add(TodoAdded(todo)),
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  context.read<TodosBloc>().add(TodoUpdated(todo.copyWith(complete: !todo.complete)));
                },
              );
            },
          );
        } else {
          return Container(key: Keys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}
