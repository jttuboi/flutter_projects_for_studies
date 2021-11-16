import 'package:flutter/material.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/models/models.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.todo,
    required this.onDismissed,
    required this.onTap,
    required this.onCheckboxChanged,
    Key? key,
  }) : super(key: key);

  final Todo todo;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Keys.todoItem(todo.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: Keys.todoItemCheckbox(todo.id),
          value: todo.complete,
          onChanged: (value) => onCheckboxChanged(value!),
        ),
        title: Hero(
          tag: '${todo.id}__heroTag',
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.task,
              key: Keys.todoItemTask(todo.id),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: todo.note.isNotEmpty
            ? Text(
                todo.note,
                key: Keys.todoItemNote(todo.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
