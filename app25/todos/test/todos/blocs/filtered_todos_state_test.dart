// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('FilteredTodosState', () {
    group('FilteredTodosLoadInProgress', () {
      test('toString returns correct value', () {
        final event = FilteredTodosLoadInProgress();
        expect(event.toString(), 'FilteredTodosLoadInProgress()');
      });
    });

    group('FilteredTodosLoadSuccess', () {
      test('instancied with todos and filter', () {
        final event = FilteredTodosLoadSuccess(filteredTodos: todos, currentFilter: VisibilityFilter.all);
        expect(event.filteredTodos, todos);
        expect(event.currentFilter, VisibilityFilter.all);
      });

      test('toString returns correct value', () {
        final event = FilteredTodosLoadSuccess(filteredTodos: todos, currentFilter: VisibilityFilter.all);
        expect(event.toString(), 'FilteredTodosLoadSuccess([${Todo('task', id: 'id', note: 'note', complete: true)}], VisibilityFilter.all)');
      });
    });
  });
}

final todos = [Todo('task', id: 'id', note: 'note', complete: true)];
