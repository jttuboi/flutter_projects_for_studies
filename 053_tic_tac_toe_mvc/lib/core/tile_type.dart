enum TileType {
  none,
  round,
  cross,
}

extension TileTypeExtension on TileType {
  bool get isNone => this == TileType.none;
  bool get isRound => this == TileType.round;
  bool get isCross => this == TileType.cross;
  String get toTileString {
    if (isRound) {
      return 'O';
    } else if (isCross) {
      return 'X';
    }
    return '';
  }
}
