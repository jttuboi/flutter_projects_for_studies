import 'dart:math';
import 'package:minesweeper/models/field.dart';

class Board {
  final int rows;
  final int columns;
  final int bombsQuantity;

  final List<Field> _fields = [];

  Board({
    required this.rows,
    required this.columns,
    required this.bombsQuantity,
  }) {
    _createFields();
    _connectNeighbors();
    _randomMines();
  }

  reset() {
    _fields.forEach((f) => f.reset());
    _randomMines();
  }

  revealBombs() {
    _fields.forEach((f) => f.revealBomb());
  }

  _createFields() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(row: r, column: c));
      }
    }
  }

  _connectNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  _randomMines() {
    if (bombsQuantity > rows * columns) {
      return;
    }

    int quantity = 0;
    while (quantity < bombsQuantity) {
      int i = Random().nextInt(_fields.length);
      if (!_fields[i].mined) {
        _fields[i].mine();
        quantity++;
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((f) => f.resolved);
  }
}
