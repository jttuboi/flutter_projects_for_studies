import 'package:flutter/material.dart';

enum ButtonType { NORMAL, DARK, OPERATION }

class Button extends StatelessWidget {
  static const DEFAULT = Color(0xff707070);
  static const DARK = Color(0xff525252);
  static const OPERATION = Color(0xfffa9e0d);

  final String text;
  final bool bigButton;
  final ButtonType type;
  final void Function(String) callback;

  Button({
    required this.text,
    this.bigButton = false,
    required this.type,
    required this.callback,
  });

  Button.bigButton({
    required this.text,
    this.bigButton = true,
    required this.type,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      switch (type) {
        case ButtonType.NORMAL:
          return DEFAULT;
        case ButtonType.DARK:
          return DARK;
        case ButtonType.OPERATION:
          return OPERATION;
      }
    }

    return Expanded(
      flex: bigButton ? 2 : 1,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
        onPressed: () => callback(text),
      ),
    );
  }
}
