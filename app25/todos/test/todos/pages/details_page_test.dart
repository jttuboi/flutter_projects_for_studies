import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';

void main() {
  group('DetailsPage', () {
    late TodosBloc todosBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
    });

    tearDown(() {
      todosBloc.close();
    });

    setUpAll(() {
      registerFallbackValue(const TodosLoadSuccess());
      registerFallbackValue(const TodosLoaded());
    });

    testWidgets('renders properly with no todos', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess());
      await tester.pumpMaterialApp(todosBloc, id: '0');

      await tester.pumpAndSettle();
      expect(find.byKey(Keys.emptyDetailsContainer), findsOneWidget);
    });

    testWidgets('renders properly with todos', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([Todo('wash car', id: '0')]));
      await tester.pumpMaterialApp(todosBloc, id: '0');

      await tester.pumpAndSettle();
      expect(find.byKey(Keys.detailsTodoItemTask), findsOneWidget);
      expect(find.text('wash car'), findsOneWidget);
    });

    testWidgets('adds const TodoUpdated when checkbox tapped', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([Todo('wash car', id: '0')]));
      when(() => todosBloc.add(const TodoUpdated(Todo('wash car', id: '0', complete: true)))).thenReturn(null);
      await tester.pumpMaterialApp(todosBloc, id: '0');

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.detailsPageCheckBox));
      verify(() => todosBloc.add(const TodoUpdated(Todo('wash car', id: '0', complete: true)))).called(1);
    });

    testWidgets('Navigates to Edit Todo Screen when Edit Tapped', (tester) async {
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([Todo('wash car', id: '0')]));
      await tester.pumpMaterialApp(todosBloc, id: '0');

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.editTodoFab));
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.editTodoPage), findsOneWidget);
    });

    testWidgets('adds const TodoUpdated when onSave called', (tester) async {
      when(() => todosBloc.add(const TodoUpdated(Todo('new todo', id: '0', complete: true)))).thenReturn(null);
      when(() => todosBloc.state).thenReturn(const TodosLoadSuccess([Todo('wash car', id: '0')]));
      await tester.pumpMaterialApp(todosBloc, id: '0');

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.editTodoFab));
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.editTodoPage), findsOneWidget);
      await tester.tap(find.byKey(Keys.taskField));
      await tester.enterText(find.byKey(Keys.taskField), 'new todo');
      await tester.tap(find.byKey(Keys.saveTodoFab));
      await tester.pumpAndSettle();
      verify(() => todosBloc.add(const TodoUpdated(Todo('new todo', id: '0')))).called(1);
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpMaterialApp(TodosBloc todosBloc, {required String id}) async {
    await pumpWidget(
      BlocProvider.value(
        value: todosBloc,
        child: MaterialApp(
          home: Scaffold(
            body: DetailsPage(id: id),
          ),
        ),
      ),
    );
  }
}
