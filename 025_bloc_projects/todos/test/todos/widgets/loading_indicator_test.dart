import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('should render correctly', (tester) async {
      const loadingIndicatorKey = Key('loading_indicator_key');
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(key: loadingIndicatorKey),
          ),
        ),
      );
      expect(find.byKey(loadingIndicatorKey), findsOneWidget);
    });
  });
}
