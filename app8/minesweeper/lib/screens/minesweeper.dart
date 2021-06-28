import 'package:flutter/material.dart';
import 'package:minesweeper/components/board_widget.dart';
import 'package:minesweeper/components/game_state.dart';
import 'package:minesweeper/components/result_widget.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/explosion_exception.dart';
import 'package:minesweeper/models/field.dart';

class Minesweeper extends StatefulWidget {
  @override
  _MinesweeperState createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  GameState _gameState = GameState.RUNNING;
  Board? _board;

  _onReset() {
    setState(() {
      _gameState = GameState.RUNNING;
      _board!.reset();
    });
  }

  _onOpen(Field field) {
    setState(() {
      if (!_gameState.isRunning()) {
        return;
      }

      try {
        field.open();
        if (_board!.resolved) {
          _gameState = GameState.WON;
        }
      } on ExplosionException {
        _gameState = GameState.ENDED;
        _board!.revealBombs();
      }
    });
  }

  _onChangeFlag(Field field) {
    setState(() {
      if (!_gameState.isRunning()) {
        return;
      }
      field.changeFlag();
      if (_board!.resolved) {
        _gameState = GameState.WON;
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int qtyColumns = 15;
      double fieldSize = width / qtyColumns;
      int qtyRows = (height / fieldSize).floor();
      int qtyBombs =
          ((qtyRows * qtyColumns) * 0.05).toInt(); // 5% of the size board

      _board = Board(
        rows: qtyRows,
        columns: qtyColumns,
        bombsQuantity: qtyBombs,
      );
    }
    return _board!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          gameState: _gameState,
          onReset: _onReset,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board: _getBoard(constraints.maxWidth, constraints.maxHeight),
                onOpen: _onOpen,
                onChangeFlag: _onChangeFlag,
              );
            },
          ),
        ),
      ),
    );
  }
}
