// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('ExtraAction', () {
    group('ExtraActionExtension', () {
      test('checks variable ExtraAction is that type', () {
        final enum1 = ExtraAction.clearCompleted;
        expect(enum1.isClearCompleted, isTrue);
        expect(enum1.isToggleAllComplete, isFalse);

        final enum2 = ExtraAction.toggleAllComplete;
        expect(enum2.isClearCompleted, isFalse);
        expect(enum2.isToggleAllComplete, isTrue);
      });
    });
  });
}
