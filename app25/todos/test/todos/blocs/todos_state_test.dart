// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('TodosState', () {
    group('TodosLoadSuccess', () {
      test('instancied with todos', () {
        final event = TodosLoadSuccess(todos);
        expect(event.todos, todos);
      });

      test('toString returns correct value', () {
        final event = TodosLoadSuccess(todos);
        expect(event.toString(), 'TodosLoadSuccess($todos)');
      });
    });

    group('TodosLoadInProgress', () {
      test('toString returns correct value', () {
        final event = TodosLoadInProgress();
        expect(event.toString(), 'TodosLoadInProgress()');
      });
    });

    group('TodosLoadFailure', () {
      test('toString returns correct value', () {
        final event = TodosLoadFailure();
        expect(event.toString(), 'TodosLoadFailure()');
      });
    });
  });
}

final todos = [Todo('task', id: 'id', note: 'note', complete: true)];
