import 'package:flutter/material.dart';
import 'package:flutter_cookbook_animation_1/animation_1.dart';

void main() => runApp(
      MaterialApp(
        routes: {
          "/": (context) => Home(),
          "/animation_1": (context) => Animation1(),
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
          ],
        ),
      ),
    );
  }
}
