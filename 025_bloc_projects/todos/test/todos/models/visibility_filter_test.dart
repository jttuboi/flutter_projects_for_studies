// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('VisibilityFilter', () {
    group('VisibilityFilterExtension', () {
      test('checks variable VisibilityFilter is that type', () {
        final enum1 = VisibilityFilter.active;
        expect(enum1.isActive, isTrue);
        expect(enum1.isAll, isFalse);
        expect(enum1.isCompleted, isFalse);

        final enum2 = VisibilityFilter.all;
        expect(enum2.isActive, isFalse);
        expect(enum2.isAll, isTrue);
        expect(enum2.isCompleted, isFalse);

        final enum3 = VisibilityFilter.completed;
        expect(enum3.isActive, isFalse);
        expect(enum3.isAll, isFalse);
        expect(enum3.isCompleted, isTrue);
      });
    });
  });
}
