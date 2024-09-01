import 'package:tic_tac_toe_mvc/core/tile_type.dart';

class Board {
  List<TileType> tiles = List.generate(9, (index) => TileType.none);

  void updateTile({required int index, required TileType tileType}) {
    final newTiles = <TileType>[];
    for (var idx = 0; idx < tiles.length; idx++) {
      if (idx != index) {
        newTiles.add(tiles[idx]);
      } else {
        newTiles.add(tileType);
      }
    }

    tiles
      ..clear()
      ..addAll(newTiles);
  }

  void reset() {
    tiles
      ..clear()
      ..addAll(List.generate(9, (index) => TileType.none));
  }

  TileType verifyWinner() {
    final strokes = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (final stroke in strokes) {
      if (tiles[stroke[0]] == tiles[stroke[1]] && tiles[stroke[0]] == tiles[stroke[2]] && !tiles[stroke[0]].isNone) {
        return tiles[stroke[0]];
      }
    }

    return TileType.none;
  }
}
