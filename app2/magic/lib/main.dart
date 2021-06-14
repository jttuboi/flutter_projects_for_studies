import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:intent/flag.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // aqui requisita a permissão para gravar algum arquivo no celular
    final statuses = [
      Permission.storage,
    ].request();

    // aqui faz com que a tela fique no modo fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Magica',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final pages = PageView(
      controller: _controller,
      children: [
        FirstScreenWidget(),
        SecondScreenWidget(),
      ],
    );
    return pages;
  }
}

class FirstScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final child = new Scaffold(
      // a imagem pega dentro do app salvo na pasta images
      // ela cobre toda tela com o maior tamanho que ela puder
      body: new Image.asset(
        "images/home1.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
    return new GestureDetector(
      onTapDown: _onTapDown,
      child: child,
    );
  }

  void _onTapDown(TapDownDetails details) {
    // pega os valores das coordenadas onde o dedo tocou na tela
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;

    int dx = (x / 80).floor(); // considera que tem 80px cada espaço
    int dy = ((y - 180) / 100).floor(); // considera que tem 100px cada espaço
    int position = dy * 5 + dx; // calcula a posição que o dedo tocou

    print("x=$x y=$y $dx $dy $position");

    _save(position);

    // +----------------------------------+ -----
    // | 80px | 80px | 80px | 80px | 80px |
    // |                                  | 180px
    // |                                  |
    // |                            ----- | -----
    // |                            100px |
    // |                            ----- |
    // |                            100px |
    // |                            ----- |
    // |                            100px |
    // |                            ----- |
    // |                            100px |
    // |                            ----- |
    // |                            100px |
    // |                            ----- | -----
    // |                                  |
    // |                                  | XXXpx
    // |                                  |
    // +----------------------------------+ -----
  }

  void _save(int position) async {
    // a função dá o acesso à pasta temporária
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/efeito-$position.jpg";
    print(savePath);

    // o link é algum local na internet que contém a imagem. esse link é igual o exemplo do vídeo
    await Dio().download(
        "https://github.com/guilhermesilveira/flutter-magic/raw/main/efeito-$position.jpg",
        savePath);

    // slava a imagem na galeria
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
  }
}

class SecondScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final child = new Scaffold(
      // a imagem pega dentro do app salvo na pasta images
      // ela cobre toda tela com o maior tamanho que ela puder
      body: new Image.asset(
        "images/home1.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
    return new GestureDetector(
      onTap: _openGallery,
      child: child,
    );
  }

  void _openGallery() {
    // quando clica na tela, ele abre a galeria
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_VIEW)
      ..setType("image/*")
      ..addFlag(Flag.FLAG_ACTIVITY_NEW_TASK)
      ..startActivity().catchError((e) => print(e));
  }
}
