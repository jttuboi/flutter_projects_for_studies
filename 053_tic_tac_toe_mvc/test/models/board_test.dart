import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_mvc/core/tile_type.dart';
import 'package:tic_tac_toe_mvc/models/board.dart';

void main() {
  group('Board', () {
    late Board board;

    setUp(() {
      board = Board();
    });

    test('starts with tiles length == 9 and all type == none', () {
      expect(board.tiles.length, 9);
      expect(board.tiles, tilesWithAllTypeNone);
    });

    group('updates', () {
      test('tile[0] with tile type O', () {
        const indexTileToUpdate = 0;
        board.updateTile(index: indexTileToUpdate, tileType: TileType.round);

        expect(board.tiles.length, 9);
        expect(board.tiles[indexTileToUpdate], TileType.round);
      });

      test('tile[8] with tile type X', () {
        const indexTileToUpdate = 0;
        board.updateTile(index: indexTileToUpdate, tileType: TileType.cross);

        expect(board.tiles.length, 9);
        expect(board.tiles[indexTileToUpdate], TileType.cross);
      });

      test('some tiles', () {
        board
          ..tiles = initTiles
          ..updateTile(index: 3, tileType: TileType.cross)
          ..updateTile(index: 4, tileType: TileType.cross)
          ..updateTile(index: 5, tileType: TileType.round);

        expect(board.tiles.length, 9);
        expect(board.tiles, updatesSomeTilesExpected);
      });
    });

    test('resets tiles', () {
      board.tiles = initTiles;

      // ignore: cascade_invocations
      board.reset();
      expect(board.tiles.length, 9);
      expect(board.tiles, tilesWithAllTypeNone);
    });

    group('verifies winner', () {
      test('cross in [0 1 2]', () {
        board
          ..updateTile(index: 0, tileType: TileType.cross)
          ..updateTile(index: 1, tileType: TileType.cross)
          ..updateTile(index: 2, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('cross in [3 4 5]', () {
        board
          ..updateTile(index: 3, tileType: TileType.cross)
          ..updateTile(index: 4, tileType: TileType.cross)
          ..updateTile(index: 5, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('cross in [6 7 8]', () {
        board
          ..updateTile(index: 6, tileType: TileType.cross)
          ..updateTile(index: 7, tileType: TileType.cross)
          ..updateTile(index: 8, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('cross in [0 3 6]', () {
        board
          ..updateTile(index: 0, tileType: TileType.cross)
          ..updateTile(index: 3, tileType: TileType.cross)
          ..updateTile(index: 6, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('cross in [1 4 7]', () {
        board
          ..updateTile(index: 1, tileType: TileType.cross)
          ..updateTile(index: 4, tileType: TileType.cross)
          ..updateTile(index: 7, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('cross in [2 5 8]', () {
        board
          ..updateTile(index: 2, tileType: TileType.cross)
          ..updateTile(index: 5, tileType: TileType.cross)
          ..updateTile(index: 8, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('cross in [0 4 8]', () {
        board
          ..updateTile(index: 0, tileType: TileType.cross)
          ..updateTile(index: 4, tileType: TileType.cross)
          ..updateTile(index: 8, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('cross in [2 4 6]', () {
        board
          ..updateTile(index: 2, tileType: TileType.cross)
          ..updateTile(index: 4, tileType: TileType.cross)
          ..updateTile(index: 6, tileType: TileType.cross);

        final result = board.verifyWinner();
        expect(result, TileType.cross);
      });

      test('none', () {
        board
          ..updateTile(index: 2, tileType: TileType.cross)
          ..updateTile(index: 4, tileType: TileType.round);

        final result = board.verifyWinner();
        expect(result, TileType.none);
      });
    });
  });
}

final tilesWithAllTypeNone = [
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

final initTiles = [
  TileType.cross,
  TileType.cross,
  TileType.round,
  TileType.none,
  TileType.none,
  TileType.none,
  TileType.round,
  TileType.round,
  TileType.cross,
];

final updatesSomeTilesExpected = [
  TileType.cross,
  TileType.cross,
  TileType.round,
  TileType.cross,
  TileType.cross,
  TileType.round,
  TileType.round,
  TileType.round,
  TileType.cross,
];
