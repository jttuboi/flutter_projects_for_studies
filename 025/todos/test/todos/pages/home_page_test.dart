import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';

void main() {
  group('HomePage', () {
    late TodosBloc todosBloc;
    late FilteredTodosBloc filteredTodosBloc;
    late TabBloc tabBloc;
    late StatsBloc statsBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
      filteredTodosBloc = MockFilteredTodosBloc();
      tabBloc = MockTabBloc();
      statsBloc = MockStatsBloc();
    });

    setUpAll(() {
      registerFallbackValue(const TodosLoadSuccess());
      registerFallbackValue(const TodosLoaded());
      registerFallbackValue(const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.all));
      registerFallbackValue(const FilterUpdated(VisibilityFilter.all));
      registerFallbackValue(AppTab.todos);
      registerFallbackValue(const TabUpdated(AppTab.todos));
      registerFallbackValue(const StatsLoadInProgress());
      registerFallbackValue(const StatsUpdated([]));
    });

    tearDown(() {
      todosBloc.close();
      filteredTodosBloc.close();
      tabBloc.close();
      statsBloc.close();
    });

    testWidgets('renders correctly', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess());
      when(() => tabBloc.state).thenAnswer((_) => AppTab.todos);
      when(() => filteredTodosBloc.state).thenAnswer((_) => const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.all));
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<TodosBloc>.value(value: todosBloc),
            BlocProvider<FilteredTodosBloc>.value(value: filteredTodosBloc),
            BlocProvider<TabBloc>.value(value: tabBloc),
            BlocProvider<StatsBloc>.value(value: statsBloc),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: HomePage(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(Keys.addTodoFab), findsOneWidget);
      expect(find.text('Flutter todos'), findsOneWidget);
    });

    testWidgets('Navigates to /addTodo when Floating Action Button is tapped', (tester) async {
      when(() => todosBloc.state).thenAnswer((_) => const TodosLoadSuccess());
      when(() => tabBloc.state).thenAnswer((_) => AppTab.todos);
      when(() => filteredTodosBloc.state).thenAnswer((_) => const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.all));
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<TodosBloc>.value(value: todosBloc),
            BlocProvider<FilteredTodosBloc>.value(value: filteredTodosBloc),
            BlocProvider<TabBloc>.value(value: tabBloc),
            BlocProvider<StatsBloc>.value(value: statsBloc),
          ],
          child: MaterialApp(
            home: const Scaffold(
              body: HomePage(),
            ),
            routes: {
              Routes.addTodo: (context) {
                return AddEditPage(
                  key: Keys.addTodoPage,
                  onSave: (task, note) {},
                  isEditing: false,
                );
              },
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Keys.addTodoFab));
      await tester.pumpAndSettle();
      expect(find.byType(AddEditPage), findsOneWidget);
    });
  });
}
