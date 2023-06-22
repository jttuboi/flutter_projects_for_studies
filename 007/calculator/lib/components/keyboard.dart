import 'package:calculator/components/button.dart';
import 'package:calculator/components/button.row.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) callback;

  Keyboard(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          ButtonRow([
            Button.bigButton(
                text: "AC", type: ButtonType.DARK, callback: callback),
            //Button(text: "+/-"),
            Button(text: "%", type: ButtonType.DARK, callback: callback),
            Button(text: "/", type: ButtonType.OPERATION, callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "7", type: ButtonType.NORMAL, callback: callback),
            Button(text: "8", type: ButtonType.NORMAL, callback: callback),
            Button(text: "9", type: ButtonType.NORMAL, callback: callback),
            Button(text: "x", type: ButtonType.OPERATION, callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "4", type: ButtonType.NORMAL, callback: callback),
            Button(text: "5", type: ButtonType.NORMAL, callback: callback),
            Button(text: "6", type: ButtonType.NORMAL, callback: callback),
            Button(text: "-", type: ButtonType.OPERATION, callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "1", type: ButtonType.NORMAL, callback: callback),
            Button(text: "2", type: ButtonType.NORMAL, callback: callback),
            Button(text: "3", type: ButtonType.NORMAL, callback: callback),
            Button(text: "+", type: ButtonType.OPERATION, callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button.bigButton(
                text: "0", type: ButtonType.NORMAL, callback: callback),
            Button(text: ".", type: ButtonType.NORMAL, callback: callback),
            Button(text: "=", type: ButtonType.OPERATION, callback: callback),
          ]),
        ],
      ),
    );
  }
}
