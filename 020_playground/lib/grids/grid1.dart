import 'package:flutter/material.dart';

final List<Map> myProducts =
    List.generate(1000, (index) => {"id": index, "name": "Product $index"})
        .toList();

class Grid1 extends StatelessWidget {
  const Grid1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            // define o tamanho dos playground na vertical
            //mainAxisExtent: 201,
            // define o tamanho maximo dos playground na horizontal
            maxCrossAxisExtent: 190,
            childAspectRatio: 3 / 2, // vertical / horizontal
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: myProducts.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.blueAccent,
              ),
              child: Text(myProducts[index]["name"]),
            );
          },
        ),
      ),
    );
  }
}
