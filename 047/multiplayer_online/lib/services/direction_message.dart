import 'package:bonfire/bonfire.dart';

class DirectionMessage {
  static const String right = "RIGHT";
  static const String left = "LEFT";
  static const String up = "UP";
  static const String upRight = '$up$right';
  static const String upLeft = '$up$left';
  static const String down = "DOWN";
  static const String downRight = '$down$right';
  static const String downLeft = '$down$left';

  static String direction(Direction direction) {
    switch (direction) {
      case Direction.up:
        return up;
      case Direction.down:
        return down;
      case Direction.right:
        return right;
      case Direction.downRight:
        return downRight;
      case Direction.upRight:
        return upRight;
      case Direction.left:
        return left;
      case Direction.downLeft:
        return downLeft;
      case Direction.upLeft:
        return upLeft;
    }
  }
}

extension DirectionToDirectionMessage on String {
  toDirection() {
    switch (this) {
      case DirectionMessage.up:
        return Direction.up;
      case DirectionMessage.down:
        return Direction.down;
      case DirectionMessage.right:
        return Direction.right;
      case DirectionMessage.downRight:
        return Direction.downRight;
      case DirectionMessage.upRight:
        return Direction.upRight;
      case DirectionMessage.left:
        return Direction.left;
      case DirectionMessage.downLeft:
        return Direction.downLeft;
      case DirectionMessage.upLeft:
        return Direction.upLeft;
    }
    return Direction.right;
  }
}
