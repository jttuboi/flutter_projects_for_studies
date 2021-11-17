import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';

void main() {
  group('ExtraActions', () {
    late TodosBloc todosBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
    });

    setUpAll(() {
      registerFallbackValue(TodosLoadInProgress());
      registerFallbackValue(TodosLoaded());
    });

    tearDown(() {
      todosBloc.close();
    });

    testWidgets('renders an empty Container if state is not TodosLoaded', (tester) async {
      when(() => todosBloc.state).thenReturn(TodosLoadInProgress());
      await tester.pumpTodosBloc(todosBloc);

      expect(find.byKey(Keys.extraActionsEmptyContainer), findsOneWidget);
    });

    testWidgets('renders PopupMenuButton with mark all done if state is TodosLoaded with incomplete todos', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([Todo('walk dog')]));
      await tester.pumpTodosBloc(todosBloc);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.extraActionsPopupMenuButton));
      await tester.pump(); // animation
      expect(find.byKey(Keys.toggleAll), findsOneWidget);
      expect(find.text('Clear completed'), findsOneWidget);
      expect(find.text('Mark all complete'), findsOneWidget);
    });

    testWidgets('renders PopupMenuButton with mark all incomplete if state is TodosLoaded with complete todos', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([Todo('walk dog', complete: true)]));
      await tester.pumpTodosBloc(todosBloc);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.extraActionsPopupMenuButton));
      await tester.pump();
      expect(find.byKey(Keys.toggleAll), findsOneWidget);
      expect(find.text('Clear completed'), findsOneWidget);
      expect(find.text('Mark all incomplete'), findsOneWidget);
    });

    testWidgets('tapping clear completed adds ClearCompleted', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([
        Todo('walk dog'),
        Todo('take out trash', complete: true),
      ]));
      when(() => todosBloc.add(ClearCompleted())).thenReturn(null);
      await tester.pumpTodosBloc(todosBloc);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.extraActionsPopupMenuButton));
      await tester.pump();
      expect(find.byKey(Keys.clearCompleted), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.clearCompleted));
      verify(() => todosBloc.add(ClearCompleted())).called(1);
    });

    testWidgets('tapping toggle all adds ToggleAll', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([
        Todo('walk dog'),
        Todo('take out trash'),
      ]));
      when(() => todosBloc.add(ToggleAll())).thenReturn(null);
      await tester.pumpTodosBloc(todosBloc);

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.extraActionsPopupMenuButton));
      await tester.pump();
      expect(find.byKey(Keys.toggleAll), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.toggleAll));
      verify(() => todosBloc.add(ToggleAll())).called(1);
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpTodosBloc(TodosBloc todosBloc) async {
    await pumpWidget(
      BlocProvider.value(
        value: todosBloc,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              actions: const [ExtraActions()],
            ),
            body: Container(),
          ),
        ),
      ),
    );
  }
}
