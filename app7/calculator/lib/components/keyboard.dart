import 'package:calculator/components/button.dart';
import 'package:calculator/components/button.row.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          ButtonRow([
            Button.bigButton(text: "AC"),
            //Button(text: "+/-"),
            Button(text: "%"),
            Button.operation(text: "/"),
          ]),
          ButtonRow([
            Button(text: "7"),
            Button(text: "8"),
            Button(text: "9"),
            Button.operation(text: "x"),
          ]),
          ButtonRow([
            Button(text: "4"),
            Button(text: "5"),
            Button(text: "6"),
            Button.operation(text: "-"),
          ]),
          ButtonRow([
            Button(text: "1"),
            Button(text: "2"),
            Button(text: "3"),
            Button.operation(text: "+"),
          ]),
          ButtonRow([
            Button.bigButton(text: "0"),
            Button(text: "."),
            Button.operation(text: "="),
          ]),
        ],
      ),
    );
  }
}
