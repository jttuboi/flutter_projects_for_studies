import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';

void main() {
  group('Stats', () {
    late StatsBloc statsBloc;

    setUp(() {
      statsBloc = MockStatsBloc();
    });

    tearDown(() {
      statsBloc.close();
    });

    setUpAll(() {
      registerFallbackValue(const StatsLoadInProgress());
      registerFallbackValue(const StatsLoadSuccess(0, 0));
      registerFallbackValue(const StatsUpdated([]));
    });

    testWidgets('should render LoadingIndicator when state is StatsLoading', (tester) async {
      when(() => statsBloc.state).thenAnswer((_) => const StatsLoadInProgress());
      await tester.pumpStatsTab(statsBloc);

      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(Keys.statsLoadInProgressIndicator), findsOneWidget);
    });

    testWidgets('should render correct stats when state is StatsLoaded(0, 0)', (tester) async {
      when(() => statsBloc.state).thenAnswer((_) => const StatsLoadSuccess(0, 0));
      await tester.pumpStatsTab(statsBloc);

      await tester.pumpAndSettle();
      final numActiveFinder = find.byKey(Keys.statsNumActive);
      final numCompletedFinder = find.byKey(Keys.statsNumCompleted);
      expect(numActiveFinder, findsOneWidget);
      expect((numActiveFinder.evaluate().first.widget as Text).data, '0');
      expect(numCompletedFinder, findsOneWidget);
      expect((numCompletedFinder.evaluate().first.widget as Text).data, '0');
    });

    testWidgets('should render correct stats when state is StatsLoaded(2, 1)', (tester) async {
      when(() => statsBloc.state).thenAnswer((_) => const StatsLoadSuccess(2, 1));
      await tester.pumpStatsTab(statsBloc);

      await tester.pumpAndSettle();
      final numActiveFinder = find.byKey(Keys.statsNumActive);
      final numCompletedFinder = find.byKey(Keys.statsNumCompleted);
      expect(numActiveFinder, findsOneWidget);
      expect((numActiveFinder.evaluate().first.widget as Text).data, '2');
      expect(numCompletedFinder, findsOneWidget);
      expect((numCompletedFinder.evaluate().first.widget as Text).data, '1');
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpStatsTab(StatsBloc statsBloc) async {
    await pumpWidget(
      BlocProvider.value(
        value: statsBloc,
        child: const MaterialApp(
          home: Scaffold(
            body: StatsTab(),
          ),
        ),
      ),
    );
  }
}
