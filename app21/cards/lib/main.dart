import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // https://www.woolha.com/tutorials/flutter-card-widget-example
              Card1(),
              Card2(),
              Card3(),
              Card4(),
              Card5(),
            ],
          ),
        ),
      ),
    ),
  );
}

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        color: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              leading: Icon(Icons.album, size: 50),
              title: Text("Heart Shaker"),
              subtitle: Text("TWICE"),
            ),
            ButtonTheme(
              child: ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Edit',
                        style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class Card4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class Card5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
