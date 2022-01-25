import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/screens/color_screen.dart';

// aqui que fica o static Route que criava anteriormente
class ColorPage extends Page {
  ColorPage({required this.selectedColorCode, required this.onShapeTap}) : super(key: ValueKey(selectedColorCode));

  final Function(ShapeBorderType) onShapeTap;
  final String selectedColorCode;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => ColorScreen(
        onShapeTap: onShapeTap,
        colorCode: selectedColorCode,
      ),
    );
  }
}
