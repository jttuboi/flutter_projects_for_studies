import 'package:flutter/material.dart';

final List<Map> myProducts =
    List.generate(1000, (index) => {"id": index, "name": "Product $index"})
        .toList();

class Grid3 extends StatelessWidget {
  const Grid3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          // dá uma quantidade de coluna fixa
          crossAxisCount: 3,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          // os filhos precisam ser adicionados manualmente
          children: [
            CardK(1),
            CardK(2),
            CardK(3),
            CardK(4),
            CardK(5),
            CardK(6),
            CardK(7),
            CardK(8),
            CardK(9),
            CardK(10),
            CardK(11),
            CardK(12),
          ],
        ),
      ),
    );
  }
}

class CardK extends StatelessWidget {
  const CardK(this.number, {Key? key}) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent,
      child: Center(child: Text("1")),
    );
  }
}
