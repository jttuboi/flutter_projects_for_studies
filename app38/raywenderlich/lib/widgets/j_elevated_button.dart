import 'package:flutter/material.dart';

class JElevatedButton extends StatelessWidget {
  const JElevatedButton({
    required this.title,
    required this.onPressed,
    this.style = JElevatedButtonStyle.none,
    this.textStyle = JElevatedButtonTextStyle.none,
    Key? key,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;
  final JElevatedButtonStyle style;
  final JElevatedButtonTextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _style(context),
      onPressed: onPressed,
      child: Text(title, style: _textStyle),
    );
  }

  ButtonStyle? _style(BuildContext context) => (style == JElevatedButtonStyle.none)
      ? null
      : (style == JElevatedButtonStyle.white)
          ? ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: const BorderSide(color: Colors.white))),
            )
          : ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0), side: BorderSide(color: Theme.of(context).primaryColor))),
            );

  TextStyle? get _textStyle => (textStyle == JElevatedButtonTextStyle.none) ? null : TextStyle(color: Colors.white);
}

enum JElevatedButtonStyle {
  none,
  white,
  primaryColor,
}

enum JElevatedButtonTextStyle {
  none,
  white,
}
