import 'package:flutter/material.dart';

class Animation4 extends StatefulWidget {
  @override
  _Animation4State createState() => _Animation4State();
}

class _Animation4State extends State<Animation4> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fade in/out")),
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0, // 0 - invisible, 1 - visible
          duration: Duration(milliseconds: 500),
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ),
    );
  }
}
