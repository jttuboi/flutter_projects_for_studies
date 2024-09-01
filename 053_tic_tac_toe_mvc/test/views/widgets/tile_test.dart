import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_mvc/core/tile_type.dart';
import 'package:tic_tac_toe_mvc/views/widgets/tile.dart';

void main() {
  group('Tile', () {
    test('throws a AssertionError when uses tileType == none and onTap == null', () {
      expect(() {
        Tile(TileType.none);
      }, throwsA(predicate((e) => e is AssertionError && e.message == 'when tileType == none, onTap must not be null')));
    });

    testWidgets('uses NoneTilePainter and InkWell when TileType is none', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Tile(TileType.none, onTap: () {}),
      ));

      final customPaintFinder = find.descendant(of: find.byType(Tile), matching: find.byType(CustomPaint));
      expect(customPaintFinder, findsOneWidget);
      expect((tester.firstWidget(customPaintFinder) as CustomPaint).painter, isA<NoneTilePainter>());
      final materialFinder = find.descendant(of: customPaintFinder, matching: find.byType(Material));
      expect(materialFinder, findsOneWidget);
      expect((tester.firstWidget(materialFinder) as Material).color, isSameColorAs(Colors.transparent));
      expect(find.descendant(of: materialFinder, matching: find.byType(InkWell)), findsOneWidget);
    });

    testWidgets('uses RoundTilePainter when TileType is round', (tester) async {
      await tester.pumpWidget(Tile(TileType.round));

      expect(find.byType(CustomPaint), findsOneWidget);
      expect((tester.firstWidget(find.byType(CustomPaint)) as CustomPaint).painter, isA<RoundTilePainter>());
      expect(find.descendant(of: find.byType(CustomPaint), matching: find.byType(Material)), findsNothing);
    });

    testWidgets('uses CrossTilePainter when TileType is cross', (tester) async {
      await tester.pumpWidget(Tile(TileType.cross));

      expect(find.byType(CustomPaint), findsOneWidget);
      expect((tester.firstWidget(find.byType(CustomPaint)) as CustomPaint).painter, isA<CrossTilePainter>());
      expect(find.descendant(of: find.byType(CustomPaint), matching: find.byType(Material)), findsNothing);
    });
  });
}
