// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('StatsEvent', () {
    group('StatsUpdated', () {
      test('instancied with todos', () {
        final event = StatsUpdated(todos);
        expect(event.todos, todos);
      });

      test('toString returns correct value', () {
        final event = StatsUpdated(todos);
        expect(event.toString(), 'StatsUpdated([${Todo('task', id: 'id', note: 'note', complete: true)}])');
      });
    });
  });
}

final todos = [Todo('task', id: 'id', note: 'note', complete: true)];
