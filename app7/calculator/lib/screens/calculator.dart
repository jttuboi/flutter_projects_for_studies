import 'package:calculator/components/display.dart';
import 'package:calculator/components/keyboard.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  _onPressed(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: [
          Display("123"),
          Keyboard(_onPressed),
        ],
      ),
    );
  }
}
