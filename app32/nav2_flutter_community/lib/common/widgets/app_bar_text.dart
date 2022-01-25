import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({
    required this.appBarColor,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Color appBarColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(appBarColor);
    Color textColor = brightness == Brightness.light ? Colors.black : Colors.white;
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6!.copyWith(color: textColor),
    );
  }
}
