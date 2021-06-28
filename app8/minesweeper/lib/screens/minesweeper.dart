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
  Board _board = Board(rows: 12, columns: 12, bombsQuantity: 3);

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: _won,
          onReset: _onReset,
        ),
        body: Container(
          child: BoardWidget(
            board: _board,
            onOpen: _onOpen,
            onChangeFlag: _onChangeFlag,
          ),
        ),
      ),
    );
  }
}
