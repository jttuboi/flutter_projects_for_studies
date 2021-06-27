import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DEFAULT = Color(0xff707070);
  static const DARK = Color(0xff525252);
  static const OPERATION = Color(0xfffa9e0d);
  static const HOVER = Color(0xff808080);

  final String? text;
  final bool bigButton;
  final Color color;
  final void Function(String)? callback;

  Button({
    @required this.text,
    this.bigButton = false,
    this.color = DEFAULT,
    @required this.callback,
  });

  Button.bigButton({
    @required this.text,
    this.bigButton = true,
    this.color = DEFAULT,
    @required this.callback,
  });

  Button.operation({
    @required this.text,
    this.bigButton = false,
    this.color = OPERATION,
    @required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return HOVER;
      }
      return color;
    }

    return Expanded(
      flex: bigButton ? 2 : 1,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
        child: Text(
          "$text",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
        onPressed: () => callback!("$text"),
      ),
    );
  }
}
