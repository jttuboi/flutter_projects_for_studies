import 'package:flutter/material.dart';
import 'package:page_view_dynamically/content.page.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class Data {
  Data(this.value);
  final String value;
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController _controller = PageController(initialPage: 0);
  List<Data> datas = [
    Data("oi"),
    Data("tchau"),
    Data("outro data"),
    Data("pulando"),
    Data("correndo"),
    Data("dando voltas"),
    Data("caindo"),
  ];

  int _pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.1,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // GESTURE
              // qualquer widget que não esteja sendo criado pelo PageView()
              // pode sofrer interação, então esse botão que não tem relação
              // com o PageView() pode ser ativado durante a animação de mudança de pagina
              ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
                SnackBar(
                  content: Text("botao de sair"),
                  duration: Duration(milliseconds: 300),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                _pageIdx++;
                if (_pageIdx < datas.length) {
                  _controller.animateToPage(
                    _pageIdx,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.linear,
                  );
                }
              },
            )
          ],
        ),

        // BLOQUEIO DE GESTURE
        // quando está trocando de página, os botoes e qualquer coisa na tela
        // é automaticamente bloqueado

        // EXCESSO DE WIDGETS CONSTRUÍDOS
        // o page view builder é dinamico, entao ele nao cria um monte de telas e vai acumulando
        // na memoria. cada vez que ele muda de pagina completa, ele deleta o page que era o
        // anterior apenas sobrando o atual.
        body: PageView.builder(
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          itemBuilder: (context, index) {
            return Content(pageNumber: index, data: datas[index].value);
          },
        ),

        // PAGE VIEW BASICO
        // body: PageView(
        //   physics: NeverScrollableScrollPhysics(),
        //   children: [
        //     Content(pageNumber: 0),
        //     Content(pageNumber: 1),
        //     Content(pageNumber: 2),
        //     Content(pageNumber: 3),
        //   ],
        // ),
      ),
    );
  }
}
