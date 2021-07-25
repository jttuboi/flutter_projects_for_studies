import 'package:cards/heart_shaker.dart';
import 'package:cards/mars.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routes: {
      "/": (context) => Home(),
      "/heart_shaker": (context) => HeartShaker(),
      "/mars": (context) => Mars(),
    },
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // https://www.woolha.com/tutorials/flutter-card-widget-example
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/heart_shaker"),
              child: Text("Heart Shaker"),
            ),
            // https://github.com/sergiandreplace/flutter_planets_tutorial
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/mars"),
              child: Text("Mars"),
            ),
          ],
        ),
      ),
    );
  }
}
