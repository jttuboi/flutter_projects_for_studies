import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_mvc/core/tile_type.dart';
import 'package:tic_tac_toe_mvc/models/current_player.dart';

void main() {
  group('CurrentPlayer', () {
    late CurrentPlayer currentPlayer;

    setUp(() {
      currentPlayer = CurrentPlayer();
    });

    test('starts with currentPlayer == round', () {
      expect(currentPlayer.tileType.isRound, isTrue);
    });

    test('resets the current player to round when is cross', () {
      currentPlayer.tileType = TileType.cross;

      // ignore: cascade_invocations
      currentPlayer.reset();
      expect(currentPlayer.tileType.isRound, isTrue);
    });

    test('resets the current player to round when is round', () {
      currentPlayer.tileType = TileType.round;

      // ignore: cascade_invocations
      currentPlayer.reset();
      expect(currentPlayer.tileType.isRound, isTrue);
    });

    test('changes the current player to round when is cross', () {
      currentPlayer.tileType = TileType.round;

      // ignore: cascade_invocations
      currentPlayer.changePlayer();
      expect(currentPlayer.tileType.isCross, isTrue);
    });

    test('changes the current player to cross when is round', () {
      currentPlayer.tileType = TileType.cross;

      // ignore: cascade_invocations
      currentPlayer.changePlayer();
      expect(currentPlayer.tileType.isRound, isTrue);
    });
  });
}
