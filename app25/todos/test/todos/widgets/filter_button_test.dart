import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';

void main() {
  group('FilterButton', () {
    late FilteredTodosBloc filteredTodosBloc;

    setUp(() {
      filteredTodosBloc = MockFilteredTodosBloc();
    });

    setUpAll(() {
      registerFallbackValue(const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.all));
      registerFallbackValue(const FilterUpdated(VisibilityFilter.all));
    });

    tearDown(() {
      filteredTodosBloc.close();
    });

    testWidgets('should render properly with VisibilityFilter.all', (tester) async {
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.all);
      });
      await tester.pumpFilteredTodosBloc(filteredTodosBloc);

      await tester.pumpAndSettle();
      final filterButtonFinder = find.byKey(Keys.filterButton);
      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.allFilter), findsOneWidget);
      expect(find.byKey(Keys.activeFilter), findsOneWidget);
    });

    testWidgets('should render properly VisibilityFilter.active', (tester) async {
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.active);
      });
      await tester.pumpFilteredTodosBloc(filteredTodosBloc);

      await tester.pumpAndSettle();
      final filterButtonFinder = find.byKey(Keys.filterButton);
      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.allFilter), findsOneWidget);
      expect(find.byKey(Keys.activeFilter), findsOneWidget);
    });

    testWidgets('should render properly VisibilityFilter.completed', (tester) async {
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.completed);
      });
      await tester.pumpFilteredTodosBloc(filteredTodosBloc);

      await tester.pumpAndSettle();
      final filterButtonFinder = find.byKey(Keys.filterButton);
      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.allFilter), findsOneWidget);
      expect(find.byKey(Keys.activeFilter), findsOneWidget);
    });

    testWidgets('should add UpdateFilter when filter selected', (tester) async {
      when(() => filteredTodosBloc.state).thenAnswer((_) {
        return const FilteredTodosLoadSuccess(filteredTodos: [], currentFilter: VisibilityFilter.active);
      });
      when(() => filteredTodosBloc.add(const FilterUpdated(VisibilityFilter.all))).thenReturn(null);
      await tester.pumpFilteredTodosBloc(filteredTodosBloc);

      await tester.pumpAndSettle();
      final filterButtonFinder = find.byKey(Keys.filterButton);
      final allFilterFinder = find.byKey(Keys.allFilter);
      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(Keys.activeFilter), findsOneWidget);
      expect(allFilterFinder, findsOneWidget);
      await tester.tap(allFilterFinder);
      verify(() => filteredTodosBloc.add(const FilterUpdated(VisibilityFilter.all))).called(1);
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpFilteredTodosBloc(FilteredTodosBloc filteredTodosBloc) async {
    await pumpWidget(
      BlocProvider.value(
        value: filteredTodosBloc,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              actions: const [FilterButton(visible: true)],
            ),
            body: Container(),
          ),
        ),
      ),
    );
  }
}
