import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/screens/home_screen.dart';

// aqui que fica o static Route que criava anteriormente
class HomePage extends Page {
  HomePage({
    required this.onColorTap,
    required this.onLogout,
    required this.colors,
  }) : super(key: ValueKey('HomePage'));

  final Function(String) onColorTap;
  final VoidCallback onLogout;
  final List<Color> colors;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => HomeScreen(
        onColorTap: onColorTap,
        onLogout: onLogout,
        colors: colors,
      ),
    );
  }
}
