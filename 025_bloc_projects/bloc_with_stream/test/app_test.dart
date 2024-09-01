import 'package:bloc_with_stream/main.dart';
import 'package:bloc_with_stream/views/ticker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('is a MaterialApp', (tester) async {
      expect(App(), isA<MaterialApp>());
    });

    testWidgets('renders TickerPage', (tester) async {
      await tester.pumpWidget(App());
      // procura pelo TickerPage() e acha um dele dentro do App()
      expect(find.byType(TickerPage), findsOneWidget);
    });
  });
}
