import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('AddEditPage', () {
    testWidgets('should render properly when isEditing: true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddEditPage(
              isEditing: true,
              onSave: (_, __) {},
              todo: const Todo('wash dishes', id: '0'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Edit Todo'), findsOneWidget);
      expect(find.text('wash dishes'), findsOneWidget);
      expect(find.byKey(Keys.saveTodoFab), findsOneWidget);
    });

    testWidgets('should render properly when isEditing: false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddEditPage(
              isEditing: false,
              onSave: (_, __) {},
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Add Todo'), findsOneWidget);
      expect(find.byKey(Keys.saveNewTodo), findsOneWidget);
    });

    testWidgets('should call onSave when Floating Action Button is tapped', (tester) async {
      var onSavePressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddEditPage(
              isEditing: true,
              onSave: (_, __) {
                onSavePressed = true;
              },
              todo: const Todo('wash dishes'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.saveTodoFab));
      expect(onSavePressed, true);
    });

    testWidgets('should call show error if task name is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddEditPage(
              isEditing: true,
              onSave: (_, __) {},
              todo: const Todo('wash dishes'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.taskField));
      await tester.enterText(find.byKey(Keys.taskField), '');
      await tester.tap(find.byKey(Keys.saveTodoFab));
      await tester.pump();
      expect(find.text('Please enter some text'), findsOneWidget);
    });
  });
}
