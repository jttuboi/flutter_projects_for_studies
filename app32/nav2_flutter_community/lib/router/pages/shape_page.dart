import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/screens/shape_screen.dart';

// aqui que fica o static Route que criava anteriormente
class ShapePage extends Page {
  ShapePage({
    required this.shapeBorderType,
    required this.colorCode,
    required this.onLogout,
  }) : super(key: ValueKey("$colorCode$shapeBorderType"));

  final String colorCode;
  final ShapeBorderType shapeBorderType;
  final VoidCallback onLogout;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => ShapeScreen(
        colorCode: colorCode,
        shapeBorderType: shapeBorderType,
        onLogout: onLogout,
      ),
    );
  }
}
