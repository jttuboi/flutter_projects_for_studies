// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('FilteredTodosEvent', () {
    group('FilterUpdated', () {
      test('instancied with filter', () {
        final event = FilterUpdated(VisibilityFilter.completed);
        expect(event.filter, VisibilityFilter.completed);
      });

      test('toString returns correct value', () {
        final event = FilterUpdated(VisibilityFilter.active);
        expect(event.toString(), 'FilterUpdated(VisibilityFilter.active)');
      });
    });

    group('TodosUpdated', () {
      test('instancied with todos', () {
        final event = TodosUpdated(todos);
        expect(event.todos, todos);
      });

      test('toString returns correct value', () {
        final event = TodosUpdated(todos);
        expect(event.toString(), 'TodosUpdated([${Todo("take out trash", id: "0")}])');
      });
    });
  });
}

final todos = [Todo('take out trash', id: '0')];
