import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/models/models.dart';

class ExtraActions extends StatelessWidget {
  const ExtraActions() : super(key: Keys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadSuccess) {
          return PopupMenuButton<ExtraAction>(
            key: Keys.extraActionsPopupMenuButton,
            onSelected: (action) {
              if (action.isClearCompleted) {
                context.read<TodosBloc>().add(ClearCompleted());
              } else if (action.isToggleAllComplete) {
                context.read<TodosBloc>().add(ToggleAll());
              }
            },
            itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: Keys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  (BlocProvider.of<TodosBloc>(context).state as TodosLoadSuccess).todos.every((todo) => todo.complete)
                      ? 'Mark all incomplete'
                      : 'Mark all complete',
                ),
              ),
              const PopupMenuItem<ExtraAction>(
                key: Keys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text('Clear completed'),
              ),
            ],
          );
        }
        return Container(key: Keys.extraActionsEmptyContainer);
      },
    );
  }
}
