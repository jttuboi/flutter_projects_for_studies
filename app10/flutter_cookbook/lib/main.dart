import 'package:flutter/material.dart';
import 'package:flutter_cookbook/animation_1.dart';
import 'package:flutter_cookbook/animation_2.dart';

void main() => runApp(
      MaterialApp(
        routes: {
          "/": (context) => Home(),
          "/animation_1": (context) => Animation1(),
          "/animation_2": (context) => Animation2(),
        },
      ),
    );

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_1"),
              child: Text("animation 1"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_2"),
              child: Text("animation 2"),
            ),
          ],
        ),
      ),
    );
  }
}
