import 'package:flutter/material.dart';

class Hero1 extends StatelessWidget {
  const Hero1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: animals.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 9 / 10,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return Card(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    alignment: Alignment.topCenter,
                    child: Image.asset(animals[index].imageUrl),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                    alignment: Alignment.bottomCenter,
                    child: Text(animals[index].name),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Animal {
  Animal({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String imageUrl;
}

final List<Animal> animals = [
  Animal(
      id: "0",
      name: "Grasshopper",
      imageUrl: "assets/img/animals/grasshopper.png"),
  Animal(id: "1", name: "Moth", imageUrl: "assets/img/animals/moth.png"),
  Animal(id: "2", name: "Spider", imageUrl: "assets/img/animals/spider.png"),
  Animal(id: "3", name: "Koala", imageUrl: "assets/img/animals/koala.png"),
  Animal(id: "4", name: "Mule", imageUrl: "assets/img/animals/mule.png"),
  Animal(
      id: "5", name: "Partridge", imageUrl: "assets/img/animals/partridge.png"),
  Animal(id: "6", name: "Dolphin", imageUrl: "assets/img/animals/dolphin.png"),
  Animal(id: "7", name: "Dove", imageUrl: "assets/img/animals/dove.png"),
  Animal(id: "8", name: "Cheetah", imageUrl: "assets/img/animals/cheetah.png"),
  Animal(
      id: "9", name: "Crocodile", imageUrl: "assets/img/animals/crocodile.png"),
  Animal(id: "10", name: "Penguin", imageUrl: "assets/img/animals/penguin.png"),
];
