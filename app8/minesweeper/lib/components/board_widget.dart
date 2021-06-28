import 'package:flutter/material.dart';
import 'package:minesweeper/components/field_widget.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/field.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final Function(Field) onOpen;
  final Function(Field) onChangeFlag;

  BoardWidget({
    required this.board,
    required this.onOpen,
    required this.onChangeFlag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((f) {
          return FieldWidget(
            field: f,
            onOpen: onOpen,
            onChangeFlag: onChangeFlag,
          );
        }).toList(),
      ),
    );
  }
}
