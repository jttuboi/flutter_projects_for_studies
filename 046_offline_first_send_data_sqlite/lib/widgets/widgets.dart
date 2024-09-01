import 'package:flutter/material.dart';

enum MyButtonStyle {
  basic,
  red;
}

class Button extends StatelessWidget {
  const Button(this.label, {this.style = MyButtonStyle.basic, required this.onPressed, super.key});

  final String label;
  final MyButtonStyle style;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _style,
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 20)),
    );
  }

  ButtonStyle? get _style {
    switch (style) {
      case MyButtonStyle.basic:
        return null;
      case MyButtonStyle.red:
        return const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white), backgroundColor: MaterialStatePropertyAll(Colors.blueAccent));
    }
  }
}
