// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('AppTab', () {
    group('AppTabExtension', () {
      test('checks variable AppTab is that type', () {
        final enum1 = AppTab.todos;
        expect(enum1.isTodosTab, isTrue);
        expect(enum1.isStatsTab, isFalse);

        final enum2 = AppTab.stats;
        expect(enum2.isTodosTab, isFalse);
        expect(enum2.isStatsTab, isTrue);
      });
    });
  });
}
