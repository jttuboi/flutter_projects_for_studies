import 'package:flutter/material.dart';
import 'package:tic_tac_toe_mvc/core/constants.dart';
import 'package:tic_tac_toe_mvc/core/offset.dart';
import 'package:tic_tac_toe_mvc/core/tile_type.dart';

class Tile extends StatelessWidget {
  Tile(this.tileType, {VoidCallback? onTap, Key? key})
      : _onTap = onTap,
        assert(!(tileType.isNone && onTap == null), 'when tileType == none, onTap must not be null'),
        super(key: key);

  final TileType tileType;
  final VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    CustomPainter painter = NoneTilePainter();
    if (tileType.isRound) {
      painter = RoundTilePainter();
    } else if (tileType.isCross) {
      painter = CrossTilePainter();
    }
    return CustomPaint(
      painter: painter,
      child: tileType.isNone ? Material(color: Colors.transparent, child: InkWell(onTap: _onTap)) : null,
    );
  }
}

class RoundTilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(8)), Paint()..color = playerRoundColor)
      ..drawCircle(OffsetExtension.fromSize(size / 2), size.width / 4 + 4, Paint()..color = Colors.white)
      ..drawCircle(OffsetExtension.fromSize(size / 2), size.width / 4 - 4, Paint()..color = playerRoundColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CrossTilePainter extends CustomPainter {
  final paintLine = Paint()
    ..color = Colors.white
    ..strokeWidth = 8
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(8)), Paint()..color = playerCrossColor)
      ..drawLine(OffsetExtension.fromSize(size / 4), OffsetExtension.fromSize(size * 3 / 4), paintLine)
      ..drawLine(Offset(size.width / 4, size.height * 3 / 4), Offset(size.width * 3 / 4, size.height / 4), paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NoneTilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(8)),
      Paint()..color = Colors.grey,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
