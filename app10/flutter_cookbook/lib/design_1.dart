import 'package:flutter/material.dart';

class Design1 extends StatefulWidget {
  @override
  _Design1State createState() => _Design1State();
}

class _Design1State extends State<Design1> {
  String _text = "initial text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer sample"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Header"),
            ),
            ListTile(
              title: Text("main"),
              onTap: () {
                setState(() {
                  _text = "main clicked.";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("no close popup"),
              onTap: () {
                setState(() {
                  _text = "no close popup clicked.";
                });
              },
            ),
            ListTile(
              title: Text("settings"),
              onTap: () {
                setState(() {
                  _text = "settings clicked.";
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(_text),
      ),
    );
  }
}
