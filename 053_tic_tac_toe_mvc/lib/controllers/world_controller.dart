import 'package:tic_tac_toe_mvc/core/tile_type.dart';
import 'package:tic_tac_toe_mvc/models/board.dart';
import 'package:tic_tac_toe_mvc/models/current_player.dart';
import 'package:tic_tac_toe_mvc/views/interface_controllers/word_controller.dart';

class WorldController implements IWorldController {
  WorldController() {
    _board = Board();
    _currentPlayer = CurrentPlayer();
    _reset();
  }

  late Board _board;
  late CurrentPlayer _currentPlayer;

  @override
  List<TileType> get tiles => _board.tiles;

  @override
  TileType get currentPlayer => _currentPlayer.tileType;

  @override
  void markTile(int index) {
    _board.updateTile(index: index, tileType: currentPlayer);
    _currentPlayer.changePlayer();
  }

  @override
  TileType verifyWinner() {
    return _board.verifyWinner();
  }

  @override
  void restart() {
    _reset();
  }

  void _reset() {
    _board.reset();
    _currentPlayer.reset();
  }
}
