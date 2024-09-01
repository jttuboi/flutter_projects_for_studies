import 'package:flutter/material.dart';

extension HexColor on Color {
  String toHex({bool leadingHashSign = false, bool includeAlpha = false}) => '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  Color onTextColor() {
    Brightness brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.light ? Colors.black : Colors.white;
  }
}

extension HexString on String {
  Color hexToColor() {
    return Color(int.parse(this.substring(0, 6), radix: 16) + 0xFF000000);
  }

  bool isHexColor() {
    return RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$').hasMatch(this);
  }
}
