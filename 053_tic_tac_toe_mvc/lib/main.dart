import 'package:flutter/material.dart';
import 'package:tic_tac_toe_mvc/controllers/world_controller.dart';
import 'package:tic_tac_toe_mvc/views/pages/world_page.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.grey,
      ),
      home: WorldPage(worldController: WorldController()),
    );
  }
}
