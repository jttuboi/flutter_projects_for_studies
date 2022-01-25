import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/widgets/color_gridview.dart';

// não há presença de nada de Navigator ou route, pois quem controla é o delegate
class HomeScreen extends StatelessWidget {
  HomeScreen({required this.onColorTap, Key? key}) : super(key: key);

  final Function(String) onColorTap;
  final List<Color> colors = Colors.primaries.reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: ColorGrid(
        colors: Colors.primaries.reversed.toList(),
        // joga pra outra tela um método que manda qual cor foi clicada
        onColorTap: onColorTap,
      ),
    );
  }
}
