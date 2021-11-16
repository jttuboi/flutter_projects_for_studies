import 'package:equatable/equatable.dart';
import 'package:todos/todos/todos.dart';

class Todo extends Equatable {
  const Todo(
    this.task, {
    this.id = '',
    this.note = '',
    this.complete = false,
  });

  static const empty = Todo('');

  final String id;
  final String note;
  final String task;
  final bool complete;

  @override
  List<Object> get props => [id, note, task, complete];

  Todo copyWith({
    String? id,
    String? note,
    String? task,
    bool? complete,
  }) {
    return Todo(
      task ?? this.task,
      id: id ?? this.id,
      note: note ?? this.note,
      complete: complete ?? this.complete,
    );
  }

  @override
  String toString() {
    return 'Todo($id, $task, $note, $complete)';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  // ignore: sort_constructors_first
  factory Todo.fromEntity(TodoEntity entity) {
    return Todo(entity.task, id: entity.id, note: entity.note, complete: entity.complete);
  }
}
