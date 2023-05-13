import 'package:flutter/material.dart';
import 'package:visual_1/themes/themes.dart';

////////////////////////////////////////////////////////////////////////////////
// baseado no projeto:
// https://www.figma.com/community/file/1195830433502411741
//
// Qualquer uso desse design pertencem apenas ao dono daquele projeto.
// Não irei me responsabilizar por usos indevidos.
// Apenas estou utilizando como base para aprender mais sobre programação em flutter.
//
// font: https://demofont.com/gilmer-sans-serif-font/
//
////////////////////////////////////////////////////////////////////////////////

//https://www.figma.com/file/24BQfNIBYpCGjIz5EP0vM9/FoodMood---A-Food-Delivery-App-Design-(Community)?node-id=66%3A162&t=m4MY61ehRoND02GY-0

// ICONES
// https://andronasef.is-a-good.dev/iconify_flutter/

// OUTROS VISUAIS
// https://www.figma.com/community
// alarm
// calculator https://www.figma.com/community/file/1172530429109034152
// weather
// nubank https://www.figma.com/community/file/1008542325037585291
// whatsapp https://www.figma.com/community/file/1070242961600115442

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text('asdas', style: header),
          Text('asdasd', style: light),
          Text('asdasd', style: regular),
          Text('asdasd', style: heavy),
          Text('asdasd', style: medium),
          Text('asdasd', style: bold),
          Text('asdasd', style: outline),
        ],
      ),
    );
  }
}
