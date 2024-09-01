import 'package:tic_tac_toe_mvc/core/tile_type.dart';

class CurrentPlayer {
  TileType tileType = TileType.round;

  void reset() {
    tileType = TileType.round;
  }

  void changePlayer() {
    tileType = (tileType.isRound) ? TileType.cross : TileType.round;
  }
}
