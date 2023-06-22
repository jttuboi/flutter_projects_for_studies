import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> movableItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("move the squares")),
      body: Stack(
        children: movableItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          setState(() {
            movableItems.add(MoveableStackItem());
          });
        }),
      ),
    );
  }
}

class MoveableStackItem extends StatefulWidget {
  @override
  _MoveableStackItemState createState() => _MoveableStackItemState();
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double _x = 0;
  double _y = 0;
  Color _color = Colors.black;

  @override
  void initState() {
    _color = RandomColor().randomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _y,
      left: _x,
      child: GestureDetector(
        child: Container(
          width: 50,
          height: 50,
          color: _color,
        ),
        onPanUpdate: (tapInfo) {
          setState(() {
            _x += tapInfo.delta.dx;
            _y += tapInfo.delta.dy;
          });
        },
      ),
    );
  }
}
