import 'package:nav2_flutter_community/common/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

class ColoredText extends StatelessWidget {
  const ColoredText({
    required this.color,
    this.text = '',
    Key? key,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    Color textColor = brightness == Brightness.light ? Colors.black : Colors.white;
    return Text(
      text.isEmpty ? "#${color.toHex()}" : text,
      style: Theme.of(context).textTheme.headline6!.copyWith(color: textColor),
    );
  }
}
