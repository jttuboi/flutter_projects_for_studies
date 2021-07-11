import 'package:flutter/material.dart';
import 'package:flutter_cookbook/animation_1.dart';
import 'package:flutter_cookbook/animation_2.dart';
import 'package:flutter_cookbook/animation_3.dart';
import 'package:flutter_cookbook/animation_4.dart';
import 'package:flutter_cookbook/design_1.dart';
import 'package:flutter_cookbook/design_2.dart';
import 'package:flutter_cookbook/design_3.dart';
import 'package:flutter_cookbook/design_4.dart';

void main() => runApp(
      MaterialApp(
        routes: {
          "/": (context) => Home(),
          "/animation_1": (context) => Animation1(),
          "/animation_2": (context) => Animation2(),
          "/animation_3": (context) => Animation3(),
          "/animation_4": (context) => Animation4(),
          "/design_1": (context) => Design1(),
          "/design_2": (context) => Design2(),
          "/design_3": (context) => Design3(),
          "/design_4": (context) => Design4(),
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

            // é testado animação de aparecer e desaparecer com widget AnimatedOpacity.
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_4"),
              child: Text("animation - animation fade in/out"),
            ),

            // uso do Drawer.
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_1"),
              child: Text("design - drawer"),
            ),

            // uso do SnackBar.
            // como se fosse a notificação, porém dentro do app e é mostrado na parte inferior
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_2"),
              child: Text("design - snackbar"),
            ),

            // uso de fonts diferenciadas.
            // tem a forma padrão via projeto e a forma via google_fonts
            // https://pub.dev/packages/google_fonts
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_3"),
              child: Text("design - fonts"),
            ),

            // uso de orientação
            // para celular, tem que girar o celular
            // para desktop e web, tem que mudar o tamanho da tela
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_4"),
              child: Text("design - orientation"),
            ),
          ],
        ),
      ),
    );
  }
}
