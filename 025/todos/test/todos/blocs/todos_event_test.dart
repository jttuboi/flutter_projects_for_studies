// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('TodosEvent', () {
    group('TodosLoaded', () {
      test('toString returns correct value', () {
        final event = TodosLoaded();
        expect(event.toString(), 'TodosLoaded()');
      });
    });

    group('TodoAdded', () {
      test('instancied with todo', () {
        final event = TodoAdded(todo);
        expect(event.todo, todo);
      });

      test('toString returns correct value', () {
        final event = TodoAdded(todo);
        expect(event.toString(), 'TodoAdded($todo)');
      });
    });

    group('TodoUpdated', () {
      test('instancied with todo', () {
        final event = TodoUpdated(todo);
        expect(event.todo, todo);
      });

      test('toString returns correct value', () {
        final event = TodoUpdated(todo);
        expect(event.toString(), 'TodoUpdated($todo)');
      });
    });

    group('TodoDeleted', () {
      test('instancied with todo', () {
        final event = TodoDeleted(todo);
        expect(event.todo, todo);
      });

      test('toString returns correct value', () {
        final event = TodoDeleted(todo);
        expect(event.toString(), 'TodoDeleted($todo)');
      });
    });

    group('ClearCompleted', () {
      test('toString returns correct value', () {
        final event = ClearCompleted();
        expect(event.toString(), 'ClearCompleted()');
      });
    });

    group('ToggleAll', () {
      test('toString returns correct value', () {
        final event = ToggleAll();
        expect(event.toString(), 'ToggleAll()');
      });
    });
  });
}

final todo = Todo('task', id: 'id', note: 'note', complete: true);
