import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/board.dart';

main() {
  test("win the game", () {
    Board board = Board(rows: 2, columns: 2, bombsQuantity: 0);
    board.fields[0].mine();
    board.fields[3].mine();

    board.fields[0].changeFlag();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].changeFlag();

    expect(board.resolved, isTrue);
  });
}
