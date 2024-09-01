import 'package:tic_tac_toe_mvc/core/tile_type.dart';

abstract class IWorldController {
  List<TileType> get tiles;

  TileType get currentPlayer;

  void markTile(int index);

  TileType verifyWinner();

  void restart();
}
