import 'package:flutter/material.dart';
import 'package:todos/todos/models/models.dart';

class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({
    required Todo todo,
    required VoidCallback onUndo,
    Key? key,
  }) : super(
          key: key,
          content: Text(
            'Deleted "${todo.task}"',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}
