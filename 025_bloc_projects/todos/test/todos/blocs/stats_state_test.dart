// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('StatsState', () {
    group('StatsLoadInProgress', () {
      test('toString returns correct value', () {
        final event = StatsLoadInProgress();
        expect(event.toString(), 'StatsLoadInProgress()');
      });
    });

    group('StatsLoadSuccess', () {
      test('instancied with todos and filter', () {
        final event = StatsLoadSuccess(10, 15);
        expect(event.numActive, 10);
        expect(event.numCompleted, 15);
      });

      test('toString returns correct value', () {
        final event = StatsLoadSuccess(10, 15);
        expect(event.toString(), 'StatsLoadSuccess(10, 15)');
      });
    });
  });
}
