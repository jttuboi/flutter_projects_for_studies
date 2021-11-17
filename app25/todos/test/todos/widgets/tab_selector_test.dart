import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('TabSelector', () {
    testWidgets('should render properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: TabSelector(
              onTabSelected: (_) => null,
              activeTab: AppTab.todos,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(Keys.todoTab), findsOneWidget);
      expect(find.byKey(Keys.statsTab), findsOneWidget);
    });

    testWidgets('should call onTabSelected with correct index when tab tapped', (tester) async {
      late AppTab selectedTab;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: TabSelector(
              onTabSelected: (appTab) {
                selectedTab = appTab;
              },
              activeTab: AppTab.todos,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final todoTabFinder = find.byKey(Keys.todoTab);
      final statsTabFinder = find.byKey(Keys.statsTab);
      expect(todoTabFinder, findsOneWidget);
      expect(statsTabFinder, findsOneWidget);
      await tester.tap(todoTabFinder);
      expect(selectedTab, AppTab.todos);
      await tester.tap(statsTabFinder);
      expect(selectedTab, AppTab.stats);
    });
  });
}
