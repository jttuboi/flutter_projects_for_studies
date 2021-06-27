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
                text: "AC", color: Button.DARK, callback: callback),
            //Button(text: "+/-"),
            Button(text: "%", color: Button.DARK, callback: callback),
            Button.operation(text: "/", callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "7", callback: callback),
            Button(text: "8", callback: callback),
            Button(text: "9", callback: callback),
            Button.operation(text: "x", callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "4", callback: callback),
            Button(text: "5", callback: callback),
            Button(text: "6", callback: callback),
            Button.operation(text: "-", callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "1", callback: callback),
            Button(text: "2", callback: callback),
            Button(text: "3", callback: callback),
            Button.operation(text: "+", callback: callback),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button.bigButton(text: "0", callback: callback),
            Button(text: ".", callback: callback),
            Button.operation(text: "=", callback: callback),
          ]),
        ],
      ),
    );
  }
}
