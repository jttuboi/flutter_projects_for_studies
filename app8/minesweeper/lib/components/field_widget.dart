import 'package:flutter/material.dart';
import 'package:minesweeper/models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final Function(Field) onOpen;
  final Function(Field) onChangeFlag;

  FieldWidget({
    required this.field,
    required this.onOpen,
    required this.onChangeFlag,
  });

  Widget _getImage() {
    int qtyMines = field.quantityNeighborMines;
    if (field.opened && field.mined && field.exploded) {
      return Image.asset("assets/images/bomba_0.jpeg");
    } else if (field.opened && field.mined) {
      return Image.asset("assets/images/bomba_1.jpeg");
    } else if (field.opened) {
      return Image.asset("assets/images/aberto_$qtyMines.jpeg");
    } else if (field.flagged) {
      return Image.asset("assets/images/bandeira.jpeg");
    } else {
      return Image.asset("assets/images/fechado.jpeg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // for gesture recognize
      onTap: onOpen(field),
      onLongPress: onChangeFlag(field),
      child: _getImage(),
    );
  }
}
