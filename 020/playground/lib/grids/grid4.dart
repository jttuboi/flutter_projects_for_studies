import 'package:flutter/material.dart';

final List<Map> myProducts =
    List.generate(1000, (index) => {"id": index, "name": "Product $index"})
        .toList();

class Grid4 extends StatelessWidget {
  const Grid4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
