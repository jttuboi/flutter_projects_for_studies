import 'package:flutter/material.dart';

class Hero3Page extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text("main")),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Hero3PageItem()),
            );
          },
          child: Hero(
            tag: 'flippers', // deu um nome pra tag pra linkar com filho
            child: Image.asset("assets/img/moon.png"),
          ),
        ),
      ),
    );
  }
}

class Hero3PageItem extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text("item")),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.topLeft,
        color: Colors.lightBlueAccent,
        // nao tem InkWell, então não tem como voltar clicando na imagem
        child: Hero(
          tag: 'flippers', // deu um nome pra tag pra linkar com pai
          child: SizedBox(
            width: 100.0,
            child: Image.asset("assets/img/moon.png"),
          ),
        ),
      ),
    );
  }
}
