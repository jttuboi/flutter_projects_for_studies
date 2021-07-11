import 'package:flutter/material.dart';
import 'package:flutter_cookbook/animation_1.dart';
import 'package:flutter_cookbook/animation_2.dart';
import 'package:flutter_cookbook/animation_3.dart';
import 'package:flutter_cookbook/animation_4.dart';
import 'package:flutter_cookbook/design_1.dart';
import 'package:flutter_cookbook/design_2.dart';
import 'package:flutter_cookbook/design_3.dart';
import 'package:flutter_cookbook/design_4.dart';
import 'package:flutter_cookbook/design_5.dart';
import 'package:flutter_cookbook/design_6.dart';

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
          "/design_5": (context) => Design5(),
          "/design_6": (context) => Design6(),
        },
        // design 5
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          fontFamily: "Georgia",
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 16.0, fontFamily: "Hind"),
          ),
        ),
      ),
    );

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // é testado animações diferenciadas para mudanças de tela.
            // obs: as animações funcionam com qualquer widget que aceite animações.
            // https://flutter.dev/docs/cookbook/animation/page-route-animation.html
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_1"),
              child: Text("animation - change screen"),
            ),

            // é testado animações arrastar e soltar em um widget com imagem.
            // o efeito da animação utilizada é mais complexa, usando controller
            // e SpringSimulation.
            // https://flutter.dev/docs/cookbook/animation/physics-simulation.html
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_2"),
              child: Text("animation - drag/drop container"),
            ),

            // é testado animações do container.
            // tem o widget AnimationContainer e é mostrado parte de seu uso
            // voltado para animação, já que a outra parte é o container em si
            // https://flutter.dev/docs/cookbook/animation/animated-container.html
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_3"),
              child: Text("animation - animation container"),
            ),

            // é testado animação de aparecer e desaparecer com widget AnimatedOpacity.
            // https://flutter.dev/docs/cookbook/animation/opacity-animation.html
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/animation_4"),
              child: Text("animation - animation fade in/out"),
            ),

            // uso do Drawer.
            // https://flutter.dev/docs/cookbook/design/drawer.html
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_1"),
              child: Text("design - drawer"),
            ),

            // uso do SnackBar.
            // como se fosse a notificação, porém dentro do app e é mostrado na parte inferior
            // https://flutter.dev/docs/cookbook/design/snackbars.html
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_2"),
              child: Text("design - snackbar"),
            ),

            // uso de fonts diferenciadas.
            // tem a forma padrão via projeto e a forma via google_fonts
            // https://pub.dev/packages/google_fonts
            // https://flutter.dev/docs/cookbook/design/fonts.html
            // https://flutter.dev/docs/cookbook/design/package-fonts.html (this is not made it)
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_3"),
              child: Text("design - fonts"),
            ),

            // uso de orientação
            // para celular, tem que girar o celular
            // para desktop e web, tem que mudar o tamanho da tela
            // https://flutter.dev/docs/cookbook/design/orientation.html
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_4"),
              child: Text("design - orientation"),
            ),

            // uso de themes
            // olhar no topo que tem o theme default descrito no MaterialApp
            // https://flutter.dev/docs/cookbook/design/themes
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_5"),
              child: Text("design - theme"),
            ),

            // uso de tabs
            // https://flutter.dev/docs/cookbook/design/tabs
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/design_6"),
              child: Text("design - tabs"),
            ),
          ],
        ),
      ),
    );
  }
}
