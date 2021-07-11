import 'package:flutter/material.dart';
import 'package:flutter_cookbook/animation_1.dart';
import 'package:flutter_cookbook/animation_2.dart';
import 'package:flutter_cookbook/animation_3.dart';

void main() => runApp(
      MaterialApp(
        routes: {
          "/": (context) => Home(),
          "/animation_1": (context) => Animation1(),
          "/animation_2": (context) => Animation2(),
          "/animation_3": (context) => Animation3(),
        },
      ),
    );

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // é testado animações diferenciadas para mudanças de tela.
            // obs: as animações funcionam com qualquer widget que aceite animações.
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_1"),
              child: Text("animation - change screen"),
            ),

            // é testado animações arrastar e soltar em um widget com imagem.
            // o efeito da animação utilizada é mais complexa, usando controller
            // e SpringSimulation.
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_2"),
              child: Text("animation - drag/drop container"),
            ),

            // é testado animações do container.
            // tem o widget AnimationContainer e é mostrado parte de seu uso
            // voltado para animação, já que a outra parte é o container em si
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_3"),
              child: Text("animation - animation container"),
            ),
          ],
        ),
      ),
    );
  }
}
