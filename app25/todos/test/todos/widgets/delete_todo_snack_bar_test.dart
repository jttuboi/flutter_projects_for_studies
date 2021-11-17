import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('DeleteTodoSnackBar', () {
    testWidgets('should render properly', (tester) async {
      const tapTarget = Key('tap_target_key');
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
                  key: Keys.snackbar,
                  todo: const Todo('take out trash'),
                  onUndo: () {},
                ));
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(key: tapTarget, height: 100, width: 100),
            );
          }),
        ),
      ));
      await tester.tap(find.byKey(tapTarget));
      await tester.pump();

      final snackBarFinder = find.byKey(Keys.snackbar);
      expect(snackBarFinder, findsOneWidget);
      expect(((snackBarFinder.evaluate().first.widget as SnackBar).content as Text).data, 'Deleted "take out trash"');
      expect(find.text('Undo'), findsOneWidget);
    });

    testWidgets('should call onUndo when undo tapped', (tester) async {
      var tapCount = 0;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
                  todo: const Todo('take out trash'),
                  onUndo: () {
                    ++tapCount;
                  },
                ));
              },
              child: const Text('X'),
            );
          }),
        ),
      ));
      await tester.tap(find.text('X'));
      await tester.pump(); // start animation
      await tester.pump(const Duration(milliseconds: 750));

      expect(tapCount, equals(0));
      await tester.tap(find.text('Undo'));
      expect(tapCount, equals(1));
    });
  });
}
