import 'package:playground/mask1.dart';
import 'package:playground/mask2.dart';
import 'package:playground/mask3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Shader extends StatelessWidget {
  const Shader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        // child: Container(
        //   alignment: Alignment.topCenter,
        //   margin: EdgeInsets.all(8.0),
        //   child: MaskedImage3(
        //     asset: animals[4].imageUrl,
        //     mask: "assets/img/animals/filter.png",
        //   ),
        // ),

        child: GridView.builder(
          itemCount: animals.length,
          itemBuilder: (context, index) {
            return Card(
                color: Colors.blue,
                child: Stack(
                  children: [
                    // Container(
                    //   alignment: Alignment.topCenter,
                    //   margin: EdgeInsets.all(8.0),
                    //   child: Image.asset(animals[index].imageUrl),
                    //   //AssetImage(animals[index].imageUrl),
                    // ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.all(8.0),
                      child: MaskedImage(
                          asset: animals[index].imageUrl,
                          mask: "assets/img/animals/filter.png"),
                    ),
                    // Container(
                    //   constraints:
                    //       BoxConstraints(maxHeight: 180, maxWidth: 180),
                    //   alignment: Alignment.topCenter,
                    //   margin: EdgeInsets.all(8.0),
                    //   child: MaskedImage2(
                    //       asset: animals[index].imageUrl,
                    //       mask: "assets/img/animals/filter.png"),
                    // ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
                      child: Text(animals[index].name),
                    ),
                  ],
                )

                //Center(),
                );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 5 / 6,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4),
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
