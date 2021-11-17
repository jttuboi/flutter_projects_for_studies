import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('TodoItem', () {
    testWidgets('should render properly with no note', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoItem(
              onCheckboxChanged: (_) {},
              onDismissed: (_) {},
              onTap: () {},
              todo: const Todo('wash car', id: '0'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(Keys.todoItem('0')), findsOneWidget);
      expect(find.text('wash car'), findsOneWidget);
      expect(find.byKey(Keys.todoItemNote('0')), findsNothing);
    });

    testWidgets('should render properly with note', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoItem(
              onCheckboxChanged: (_) {},
              onDismissed: (_) {},
              onTap: () {},
              todo: const Todo('wash car', note: 'some note', id: '0'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(Keys.todoItem('0')), findsOneWidget);
      expect(find.text('wash car'), findsOneWidget);
      expect(find.byKey(Keys.todoItemNote('0')), findsOneWidget);
      expect(find.text('some note'), findsOneWidget);
    });
  });
}
