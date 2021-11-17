// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('Todo', () {
    test('needs be empty', () {
      final empty = Todo.empty;
      expect(empty.id, isEmpty);
      expect(empty.task, isEmpty);
      expect(empty.note, isEmpty);
      expect(empty.complete, isFalse);
    });

    test('needs copy with new data', () {
      final oldTodo = Todo('old task', id: 'old id', note: 'old note', complete: false);

      final newCopiedTodo = oldTodo.copyWith(note: 'new note', complete: true);
      expect(newCopiedTodo.id, 'old id');
      expect(newCopiedTodo.task, 'old task');
      expect(newCopiedTodo.note, 'new note');
      expect(newCopiedTodo.complete, isTrue);

      final newCopiedTodo2 = oldTodo.copyWith(id: 'new id', task: 'new task');
      expect(newCopiedTodo2.id, 'new id');
      expect(newCopiedTodo2.task, 'new task');
      expect(newCopiedTodo2.note, 'old note');
      expect(newCopiedTodo2.complete, isFalse);
    });

    test('shows toString', () {
      final todo = Todo('task', id: 'id', note: 'note', complete: true);

      expect(todo.toString(), 'Todo(id, task, note, true)');
    });

    test('converts to TodoEntity', () {
      final todo = Todo('task', id: 'id', note: 'note', complete: true);

      expect(todo.toEntity(), TodoEntity('id', 'task', 'note', true));
    });

    test('gets Todo from TodoEntity', () {
      final todoEntity = TodoEntity('id', 'task', 'note', true);

      expect(Todo.fromEntity(todoEntity), Todo('task', id: 'id', note: 'note', complete: true));
    });
  });
}
