import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'kitten.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitten Selection',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const MyHomePage(),
    );
  }
}

final String server =
    defaultTargetPlatform == TargetPlatform.android ? "10.0.2.2" : "localhost";

final List<Kitten> _kittens = <Kitten>[
  Kitten(
    name: "Mittens",
    description: "The pinnacle of cats. When Mittens sits in your lap, "
        "you feel like royalty.",
    age: 11,
    imageUrl: "images/kitten0.jpg",
  ),
  Kitten(
    name: "Fluffy",
    description: "World's cutest kitten. Seriously. We did the research.",
    age: 3,
    imageUrl: "images/kitten1.jpg",
  ),
  Kitten(
    name: "Scooter",
    description: "Chases string faster than 9/10 competing kittens.",
    age: 2,
    imageUrl: "images/kitten2.jpg",
  ),
  Kitten(
    name: "Steve",
    description: "Steve is cool and just kind of hangs out.",
    age: 4,
    imageUrl: "images/kitten3.jpg",
  ),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Kittens"),
      ),
      body: ListView.builder(
        itemCount: _kittens.length,
        itemExtent: 60.0,
        itemBuilder: _listItemBuilder,
      ),
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _dialogBuilder(context, _kittens[index]),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          _kittens[index].name,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }

  Widget _dialogBuilder(BuildContext context, Kitten kitten) {
    ThemeData localTheme = Theme.of(context);

    return SimpleDialog(
      children: [
        Image.network(
          kitten.imageUrl,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                kitten.name,
                style: localTheme.textTheme.headline4,
              ),
              Text(
                "${kitten.age} months old",
                style: localTheme.textTheme.subtitle1?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                kitten.description,
                style: localTheme.textTheme.bodyText2,
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("I'm allergic"),
                    ),
                    SizedBox(width: 6.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Adopt"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
