import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tic_tac_toe_mvc/core/tile_type.dart';
import 'package:tic_tac_toe_mvc/views/interface_controllers/word_controller.dart';
import 'package:tic_tac_toe_mvc/views/pages/world_page.dart';
import 'package:tic_tac_toe_mvc/views/widgets/tile.dart';

void main() {
  group('WorldPage', () {
    late IWorldController worldController;

    setUp(() {
      worldController = MockWorldController();
      when(() => worldController.currentPlayer).thenReturn(TileType.round);
      when(() => worldController.tiles).thenReturn(tilesAllNone);
    });

    Future<void> pumpWorldPage(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WorldPage(worldController: worldController),
        ),
      );
    }

    group('has AppBar', () {
      testWidgets('with title showing O', (tester) async {
        when(() => worldController.currentPlayer).thenReturn(TileType.round);
        await pumpWorldPage(tester);

        expect(find.widgetWithText(AppBar, 'current: O'), findsOneWidget);
      });

      testWidgets('with title showing X', (tester) async {
        when(() => worldController.currentPlayer).thenReturn(TileType.cross);
        await pumpWorldPage(tester);

        expect(find.widgetWithText(AppBar, 'current: X'), findsOneWidget);
      });

      testWidgets('with icon autorenew_rounded', (tester) async {
        await pumpWorldPage(tester);

        expect(find.widgetWithIcon(IconButton, Icons.autorenew_rounded), findsOneWidget);
        expect((tester.firstWidget(find.byType(IconButton)) as IconButton).tooltip, 'restart');
      });

      testWidgets('with icon button calls restart()', (tester) async {
        await pumpWorldPage(tester);

        await tester.tap(find.byType(IconButton));
        verify(() => worldController.restart()).called(1);
      });
    });

    group('has body', () {
      testWidgets('with 3 columns in GridView', (tester) async {
        await pumpWorldPage(tester);

        final gridDelegate = (tester.widget(find.byType(GridView)) as GridView).gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(gridDelegate, isA<SliverGridDelegateWithFixedCrossAxisCount>());
        expect(gridDelegate.crossAxisCount, 3);
      });

      testWidgets('with 9 Tile in GridView', (tester) async {
        await pumpWorldPage(tester);

        expect(
          find.descendant(of: find.byType(GridView), matching: find.byType(Tile, skipOffstage: false), skipOffstage: false),
          findsNWidgets(9),
        );
      });
    });

    group('Tile', () {
      testWidgets('changes to round when taps on Tile none', (tester) async {
        when(() => worldController.markTile(0)).thenAnswer((invocation) {
          when(() => worldController.tiles).thenReturn(tilesWith0Round);
          when(() => worldController.verifyWinner()).thenReturn(TileType.none);
        });
        await pumpWorldPage(tester);

        await tester.tap(find.byType(Tile).at(0));
        await tester.pump();
        verify(() => worldController.markTile(0)).called(1);
        expect((tester.widget(find.byType(Tile).at(0)) as Tile).tileType, TileType.round);
        verify(() => worldController.verifyWinner()).called(1);
      });

      testWidgets('changes to cross when taps on Tile none', (tester) async {
        when(() => worldController.markTile(1)).thenAnswer((invocation) {
          when(() => worldController.tiles).thenReturn(tilesWith1Cross);
          when(() => worldController.verifyWinner()).thenReturn(TileType.none);
        });
        await pumpWorldPage(tester);

        await tester.tap(find.byType(Tile).at(1));
        await tester.pump();
        verify(() => worldController.markTile(1)).called(1);
        expect((tester.widget(find.byType(Tile).at(1)) as Tile).tileType, TileType.cross);
        verify(() => worldController.verifyWinner()).called(1);
      });

      testWidgets('changes to cross and other to round when taps on Tile none', (tester) async {
        when(() => worldController.markTile(5)).thenAnswer((invocation) {
          when(() => worldController.tiles).thenReturn(tilesWith5Cross);
          when(() => worldController.verifyWinner()).thenReturn(TileType.none);
        });
        when(() => worldController.markTile(3)).thenAnswer((invocation) {
          when(() => worldController.tiles).thenReturn(tilesWith3Round5Cross);
          when(() => worldController.verifyWinner()).thenReturn(TileType.none);
        });
        await pumpWorldPage(tester);

        await tester.tap(find.byType(Tile, skipOffstage: false).at(5));
        await tester.pump();
        verify(() => worldController.markTile(5)).called(1);
        expect((tester.widget(find.byType(Tile, skipOffstage: false).at(5)) as Tile).tileType, TileType.cross);

        await tester.tap(find.byType(Tile, skipOffstage: false).at(3));
        await tester.pump();
        verify(() => worldController.markTile(3)).called(1);
        expect((tester.widget(find.byType(Tile, skipOffstage: false).at(3)) as Tile).tileType, TileType.round);
        verify(() => worldController.verifyWinner()).called(2);
      });
    });

    group('ends game', () {
      testWidgets('with round win when stroke a line', (tester) async {
        when(() => worldController.tiles).thenReturn(tilesWith26Round0138Cross);
        when(() => worldController.markTile(4)).thenAnswer((invocation) {
          when(() => worldController.tiles).thenReturn(tilesWith246Round0138Cross);
          when(() => worldController.verifyWinner()).thenReturn(TileType.round);
        });
        await pumpWorldPage(tester);

        await tester.tap(find.byType(Tile, skipOffstage: false).at(4));
        await tester.pump();
        verify(() => worldController.markTile(4)).called(1);
        expect((tester.widget(find.byType(Tile, skipOffstage: false).at(4)) as Tile).tileType, TileType.round);
        verify(() => worldController.verifyWinner()).called(1);
        expect(find.widgetWithText(AlertDialog, 'Player O won!'), findsOneWidget);
        expect(find.widgetWithText(AlertDialog, 'Click to restart the game.'), findsOneWidget);
        expect(find.widgetWithText(ElevatedButton, 'restart'), findsOneWidget);
      });

      // TODO(jttuboi): falta testar o showDialog
    });
  });
}

class MockWorldController extends Mock implements IWorldController {}

final tilesAllNone = [
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
];

final tilesWith0Round = [
  TileType.round,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
];

final tilesWith1Cross = [
  TileType.none,
  TileType.cross,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
];

final tilesWith5Cross = [
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.cross,
  TileType.none,
  TileType.none,
  TileType.none,
];

final tilesWith3Round5Cross = [
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.round,
  TileType.none,
  TileType.cross,
  TileType.none,
  TileType.none,
  TileType.none,
];

final tilesWith26Round0138Cross = [
  TileType.cross,
  TileType.cross,
  TileType.round,
  TileType.cross,
  TileType.none,
  TileType.none,
  TileType.round,
  TileType.none,
  TileType.cross,
];

final tilesWith246Round0138Cross = [
  TileType.cross,
  TileType.cross,
  TileType.round,
  TileType.cross,
  TileType.round,
  TileType.none,
  TileType.round,
  TileType.none,
  TileType.cross,
];
