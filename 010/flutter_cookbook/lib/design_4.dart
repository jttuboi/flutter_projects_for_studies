import 'package:flutter/material.dart';

class Design4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("orientation"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => GridView.count(
          // 2 columns in portrait mode
          // 3 columns in landscape mode
          crossAxisCount: orientation == Orientation.portrait ? 2 : 5,
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                "${orientation == Orientation.portrait ? "P" : "L"}$index",
                style: Theme.of(context).textTheme.headline1,
              ),
            );
          }),
        ),
      ),
    );
  }
}
