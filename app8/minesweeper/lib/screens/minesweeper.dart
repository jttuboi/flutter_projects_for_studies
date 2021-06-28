import 'package:flutter/material.dart';
import 'package:minesweeper/components/field_widget.dart';
import 'package:minesweeper/components/result_widget.dart';
import 'package:minesweeper/models/explosion_exception.dart';
import 'package:minesweeper/models/field.dart';

class Minesweeper extends StatelessWidget {
  _onReset() {
    print("reset");
  }

  _onOpen(Field field) {
    print("open");
  }

  _onChangeFlag(Field field) {
    print("altenra marcacao");
  }

  @override
  Widget build(BuildContext context) {
    Field field = Field(row: 0, column: 0);

    try {
      field.mine();
      field.changeFlag();
    } on ExplosionException {}

    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: false,
          onReset: _onReset,
        ),
        body: Container(
          child: FieldWidget(
            field: field,
            onOpen: _onOpen,
            onChangeFlag: _onChangeFlag,
          ),
        ),
      ),
    );
  }
}
