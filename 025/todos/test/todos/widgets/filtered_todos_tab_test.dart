import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';

void main() {
  group('FilteredTodos', () {
    late TodosBloc todosBloc;
    late FilteredTodosBloc filteredTodosBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
      filteredTodosBloc = MockFilteredTodosBloc();
    });

    tearDown(() {
      todosBloc.close();
      filteredTodosBloc.close();
    });

    setUpAll(() {
      registerFallbackValue(const TodosLoadSuccess());
      registerFallbackValue(const TodoUpdated(Todo.empty));
      registerFallbackValue(const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.all));
      registerFallbackValue(const FilteredTodosLoadInProgress());
      registerFallbackValue(const FilterUpdated(VisibilityFilter.all));
    });

    testWidgets('should show loading indicator when state is TodosLoading', (tester) async {
      when(() => filteredTodosBloc.state).thenAnswer((_) => const FilteredTodosLoadInProgress());
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(Keys.todosLoading), findsOneWidget);
    });

    testWidgets('should show empty list when state is TodosLoaded with no todos', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess());
      when(() => filteredTodosBloc.state).thenAnswer((_) => const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.all));
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoListFinder = find.byKey(Keys.todoList);
      expect(todoListFinder, findsOneWidget);
      expect((todoListFinder.evaluate().first.widget as ListView).semanticChildCount, 0);
    });

    testWidgets('should show todos when state is TodosLoaded with todos', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess([Todo('wash car')]));
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [Todo('wash car')], currentFilter: VisibilityFilter.all);
      });
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoListFinder = find.byKey(Keys.todoList);
      expect(todoListFinder, findsOneWidget);
      expect((todoListFinder.evaluate().first.widget as ListView).semanticChildCount, 1);
    });

    testWidgets('should add OnCheckboxChanged when checkbox tapped', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess([Todo('wash car', id: '0')]));
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [Todo('wash car', id: '0')], currentFilter: VisibilityFilter.all);
      });
      when(() => todosBloc.add(const TodoUpdated(Todo('wash car', id: '0', complete: true)))).thenReturn(null);
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoFinder = find.byKey(Keys.todoItem('0'));
      expect(todoFinder, findsOneWidget);
      final checkboxFinder = find.byKey(Keys.todoItemCheckbox('0'));
      expect(checkboxFinder, findsOneWidget);
      await tester.tap(checkboxFinder);
      verify(() => todosBloc.add(const TodoUpdated(Todo('wash car', id: '0', complete: true)))).called(1);
    });

    testWidgets('should add DeleteTodo when dismissed', (tester) async {
      when(() => filteredTodosBloc.state).thenReturn(
        const FilteredTodosLoadSuccess(filteredTodos: [Todo('wash car', id: '0')], currentFilter: VisibilityFilter.all),
      );
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoFinder = find.byKey(Keys.todoItem('0'));
      expect(todoFinder, findsOneWidget);
      (tester.widget(find.byKey(Keys.todoItem('0'))) as Dismissible).onDismissed!(DismissDirection.endToStart);
      verify(() => todosBloc.add(const TodoDeleted(Todo('wash car', id: '0')))).called(1);
    });

    testWidgets('should add AddTodo when dismissed and Undo Tapped', (tester) async {
      when(() => filteredTodosBloc.state).thenReturn(
        const FilteredTodosLoadSuccess(filteredTodos: [Todo('wash car', id: '0')], currentFilter: VisibilityFilter.all),
      );
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoFinder = find.byKey(Keys.todoItem('0'));
      expect(todoFinder, findsOneWidget);
      (tester.widget(find.byKey(Keys.todoItem('0'))) as Dismissible).onDismissed!(DismissDirection.endToStart);
      await tester.pumpAndSettle();
      verify(() => todosBloc.add(const TodoDeleted(Todo('wash car', id: '0')))).called(1);
      expect(find.text('Undo'), findsOneWidget);
      await tester.tap(find.text('Undo'));
      verify(() => todosBloc.add(const TodoAdded(Todo('wash car', id: '0')))).called(1);
    });

    testWidgets('should Navigate to DetailsScreen when todo tapped', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess([Todo('wash car', id: '0')]));
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [Todo('wash car', id: '0')], currentFilter: VisibilityFilter.all);
      });
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoFinder = find.byKey(Keys.todoItem('0'));
      expect(todoFinder, findsOneWidget);
      await tester.tap(todoFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.todoDetailsPage), findsOneWidget);
    });

    testWidgets('should add DeleteTodo when todo deleted from DetailsScreen', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess([Todo('wash car', id: '0')]));
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [Todo('wash car', id: '0')], currentFilter: VisibilityFilter.all);
      });
      when(() => todosBloc.add(const TodoDeleted(Todo('wash car', id: '0')))).thenReturn(null);
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoFinder = find.byKey(Keys.todoItem('0'));
      expect(todoFinder, findsOneWidget);
      await tester.tap(todoFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.todoDetailsPage), findsOneWidget);
      await tester.tap(find.byKey(Keys.deleteTodoButton));
      await tester.pumpAndSettle();
      verify(() => todosBloc.add(const TodoDeleted(Todo('wash car', id: '0')))).called(1);
    });

    testWidgets('should add AddTodo when todo deleted from DetailsScreen and Undo Tapped', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess([Todo('wash car', id: '0')]));
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [Todo('wash car', id: '0')], currentFilter: VisibilityFilter.all);
      });
      when(() => todosBloc.add(const TodoDeleted(Todo('wash car', id: '0')))).thenReturn(null);
      when(() => todosBloc.add(const TodoAdded(Todo('wash car', id: '0')))).thenReturn(null);
      await tester.pumpMultiBlocProvider(todosBloc, filteredTodosBloc);

      await tester.pumpAndSettle();
      final todoFinder = find.byKey(Keys.todoItem('0'));
      expect(todoFinder, findsOneWidget);
      await tester.tap(todoFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.todoDetailsPage), findsOneWidget);
      await tester.tap(find.byKey(Keys.deleteTodoButton));
      await tester.pumpAndSettle();
      verify(() => todosBloc.add(const TodoDeleted(Todo('wash car', id: '0')))).called(1);
      await tester.tap(find.text('Undo'));
      verify(() => todosBloc.add(const TodoAdded(Todo('wash car', id: '0')))).called(1);
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpMultiBlocProvider(TodosBloc todosBloc, FilteredTodosBloc filteredTodosBloc) async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<TodosBloc>.value(value: todosBloc),
          BlocProvider<FilteredTodosBloc>.value(value: filteredTodosBloc),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: FilteredTodosTab(),
          ),
        ),
      ),
    );
  }
}
