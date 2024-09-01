// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('TabEvent', () {
    group('TabUpdated', () {
      test('instancied with todos and filter', () {
        final event = TabUpdated(AppTab.stats);
        expect(event.tab, AppTab.stats);
      });

      test('toString returns correct value', () {
        final event = TabUpdated(AppTab.todos);
        expect(event.toString(), 'TabUpdated(AppTab.todos)');
      });
    });
  });
}
