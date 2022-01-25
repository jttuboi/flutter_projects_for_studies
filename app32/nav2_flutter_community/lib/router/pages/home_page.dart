import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/screens/home_screen.dart';

// aqui que fica o static Route que criava anteriormente
class HomePage extends Page {
  HomePage({required this.onColorTap}) : super(key: ValueKey('HomePage'));

  final Function(String) onColorTap;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => HomeScreen(onColorTap: onColorTap),
    );
  }
}
