import 'package:flutter/foundation.dart';
import 'package:minesweeper/models/explosion_exception.dart';

class Field {
  final int row;
  final int column;
  final List<Field> neighbors = [];

  bool _opened = false;
  bool _flagged = false;
  bool _mined = false;
  bool _exploded = false;

  Field({
    @required this.row = 0,
    @required this.column = 0,
  });

  addNeighbor(Field neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    // the parameter neighbor == self
    // 0 0 0
    // 0 x 0
    // 0 0 0
    if (deltaRow == 0 && deltaColumn == 0) {
      return; // don't add itself
    }

    // the parameter neighbor is my neighbor
    // x x x
    // x I x
    // x x x
    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }

    // other situation, the parameter neighbor is not my neighbor
  }

  open() {
    if (_opened) {
      return; // if already opened, do nothing
    }

    _opened = true;

    // if has a mine, explode
    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    // if neighbor are secure, open the nexts neighbor (recursive here)
    if (neighborSecure) {
      neighbors.forEach((n) => n.open());
    }
  }

  revealBomb() {
    if (_mined) {
      _opened = true;
    }
  }

  mine() {
    _mined = true;
  }

  changeFlag() {
    _flagged = !_flagged;
  }

  reset() {
    _opened = false;
    _flagged = false;
    _mined = false;
    _exploded = false;
  }

  bool get opened {
    return _opened;
  }

  bool get flagged {
    return _flagged;
  }

  bool get mined {
    return _mined;
  }

  bool get exploded {
    return _exploded;
  }

  bool get resolved {
    bool minedAndFlagged = _mined && _flagged;
    bool secureAndOpened = !_mined && _opened;
    return minedAndFlagged || secureAndOpened;
  }

  bool get neighborSecure {
    return neighbors.every((n) => !n._mined);
  }

  int get quantityNeighborMines {
    return neighbors.where((n) => n.mined).length;
  }
}
