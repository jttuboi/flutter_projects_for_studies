import 'package:playground/shader/shader.dart';
import 'package:playground/grids/grid1.dart';
import 'package:playground/grids/grid2.dart';
import 'package:playground/grids/grid3.dart';
import 'package:playground/grids/grid4.dart';
import 'package:playground/hero/hero.dart';
import 'package:playground/hero/hero1.dart';
import 'package:playground/hero/hero2.dart';
import 'package:playground/hero/hero3.dart';
import 'package:playground/hero/hero4.dart';
import 'package:playground/hero/hero5.dart';
import 'package:playground/draw/draw1.dart';
import 'package:playground/draw/draw2.dart';
import 'package:playground/draw/draw3.dart';
import 'package:playground/pan/pan1.dart';
import 'package:playground/pan/pan2.dart';
import 'package:playground/pan/pan3.dart';
import 'package:playground/cards/heart_shaker.dart';
import 'package:playground/cards/mars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routes: {
      "/": (context) => Home(),
      "/heart_shaker": (context) => HeartShaker(),
      "/mars": (context) => Mars(),
      "/grid1": (context) => Grid1(),
      "/grid2": (context) => Grid2(),
      "/grid3": (context) => Grid3(),
      "/grid4": (context) => Grid4(),
      "/shader": (context) => Shader(),
      "/hero": (context) => Hero1(),
      "/hero1": (context) => Hero2Page(),
      "/hero2": (context) => Hero3Page(),
      "/hero3": (context) => Hero4Page(),
      "/hero4": (context) => Hero5Page(),
      "/hero5": (context) => Hero6Page(),
      "/draw1": (context) => Draw1(),
      "/draw2": (context) => Draw2(),
      "/draw3": (context) => Draw3(),
      "/pan1": (context) => Pan1(),
      "/pan2": (context) => Pan2(),
      "/pan3": (context) => Pan3(),
    },
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Title("cards"),
            // https://www.woolha.com/tutorials/flutter-card-widget-example
            Button("Heart Shaker", route: "/heart_shaker"),
            // https://github.com/sergiandreplace/flutter_planets_tutorial
            Button("Mars", route: "/mars"),
            Title("grids"),
            // https://www.kindacode.com/article/flutter-gridview-builder-example/
            // nesse utiliza grid view builder que utiliza delegate
            // SliverGridDelegateWithMaxCrossAxisExtent para limitar o tamanho dos playground
            // a quantidade de colunas não é fixa, ela muda respeitando o tamanho maximo dos playground
            Button("GridView.builder() fixa tam filhos", route: "/grid1"),
            // nesse utiliza grid view builder que utiliza delegate
            // SliverGridDelegateWithFixedCrossAxisCount para limitar a quantidade de colunas
            // o tamanho do playground é de acordo com o tamanho da tela
            Button("GridView.builder() fixa nro col", route: "/grid2"),
            // nesse utiliza grid view count que fixa diretamente a quantidade de coluna
            // os playground precisam ser colocados diretamente no children
            // o tamanho do playground é de acordo com o tamanho da tela
            Button("GridView.count() fixa nro col", route: "/grid3"),
            Title("shader"),
            // tentativa de uso de mascaras nos playground da grid
            // o efeito é transformar a picture em uma imagem parcialemente dissipada
            // para isso utiliza-se uma imagem preto e branco com transparencia
            // e é mesclado nas imagens
            // NAO FUNCIONA DIREITO, para celular do android funciona, mas quando vai pra
            // telas maiores ou web a imagem fica distorcida
            Button("Imagem + mask cria efeito dissolve", route: "/shader"),
            Title("hero"),
            Button("Hero", route: "/hero"),
            // https://flutter.dev/docs/development/ui/animations/hero-animations
            Button("animação grande -> pequeno", route: "/hero1"),
            Button("animação grande -> pequeno", route: "/hero2"),
            Button("animação p/ centro completo", route: "/hero3"),
            Button("animação p/ centro simplificado", route: "/hero4"),
            Button("animação p/ centro completo suavizado", route: "/hero5"),
            Title("draw"),
            // como desenhar Containers com linha curvadas utilizando CustomClip
            // e a curvatura de bezier
            // https://medium.com/flutter-comunidade-br/flutter-lineto-quadraticbezierto-34a880afa1ef
            Button("lineTo e bezierTo", route: "/draw1"),
            // como cortar a imagem deixando as bordas decoradas pelo curve bezier
            // https://iiro.dev/clipping-widgets-with-bezier-curves-in-flutter/
            Button("bezierTo em imagem", route: "/draw2"),
            // https://ptyagicodecamp.github.io/building-cross-platform-finger-painting-app-in-flutter.html
            Button("paint 1", route: "/draw3"),
            Title("pan e zoom"),
            // move pela tela, dá o zoom, igual os softwares de imagem
            // https://github.com/AlexanderArendar/overflow
            Button("move and zoom", route: "/pan1"),
            // uso do interactive viewer
            // https://api.flutter.dev/flutter/widgets/InteractiveViewer-class.html
            Button("move and zoom com interactive viewer", route: "/pan2"),

            // https://letusflutter.com/2021/01/29/flutter-interactiveviewer/
            //Button("jogo go com interactive viewer", route: "/pan3"),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.w900)),
    );
  }
}

class Button extends StatelessWidget {
  const Button(this.title, {required this.route, Key? key}) : super(key: key);

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(title),
      ),
    );
  }
}
