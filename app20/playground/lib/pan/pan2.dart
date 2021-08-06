import 'package:flutter/material.dart';

class Pan2 extends StatelessWidget {
  const Pan2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.0,
        panEnabled: true,
        scaleEnabled: true,
        constrained: true,
        child: Stack(
          children: [
            Item(x: 0, y: 0, color: Colors.redAccent),
            Item(x: 100, y: 100, color: Colors.greenAccent),
            Item(x: 200, y: 200, color: Colors.blueAccent),
            Item(x: 300, y: 300, color: Colors.yellowAccent),
            Item(x: 400, y: 400, color: Colors.cyanAccent),
            Item(x: -100, y: -100, color: Colors.pinkAccent),
            Item(x: -200, y: -200, color: Colors.orangeAccent),
            Item(x: -300, y: -300, color: Colors.purpleAccent),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.x,
    required this.y,
    required this.color,
  }) : super(key: key);

  final double x;
  final double y;
  final Color color;

  static const Size size = Size(50, 50);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Container(width: size.width, height: size.height, color: color),
          Text("$x\n$y"),
        ],
      ),
    );
  }
}
