import 'package:flutter/material.dart';
import 'package:minesweeper/components/board_widget.dart';
import 'package:minesweeper/components/field_widget.dart';
import 'package:minesweeper/components/result_widget.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/explosion_exception.dart';
import 'package:minesweeper/models/field.dart';

class Minesweeper extends StatefulWidget {
  @override
  _MinesweeperState createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  bool? _won;
  Board _board = Board(rows: 1, columns: 1, bombsQuantity: 1);

  _onReset() {
    setState(() {
      _won = null;
      _board.reset();
    });
  }

  _onOpen(Field field) {
    setState(() {
      if (_won != null) {
        return;
      }

      try {
        field.open();
        if (_board.resolved) {
          _won = true;
        }
      } on ExplosionException {
        _won = false;
        _board.revealBombs();
      }
    });
  }

  _onChangeFlag(Field field) {
    setState(() {
      if (_won != null) {
        return;
      }
      field.changeFlag();
      if (_board.resolved) {
        _won = true;
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int qtyColumns = 15;
      double fieldSize = width / qtyColumns;
      int qtyRows = (height / fieldSize).floor();

      _board = Board(
        rows: qtyRows,
        columns: qtyColumns,
        bombsQuantity: 3,
      );
    }
    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: _won,
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
