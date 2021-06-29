import 'package:flutter/material.dart';

class Animation1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // normalmente utiliza o routes do MaterialApp, passando todas as rotas
            // de cada página. Então no Navigator, utiliza-se o pushNamed para
            // indicar qual rota ele deve seguir.
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(_createRoute1()),
              child: Text("route 1"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(_createRoute2()),
              child: Text("route 2"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(_createRoute3()),
              child: Text("route 3"),
            ),
          ],
        ),
      ),
    );
  }

  Route<Object?> _createRoute1() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          Page2(title: "route 1"),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // cria a interpolação da animação no formato de curva
        // o ease faz a animação inicial ser rápida e próximo ao fim vai devagar
        var curveTween = CurveTween(curve: Curves.ease);

        // cria a interpolação da animação
        // esse tween faz com que a Page2 apareça debaixo (y=1) para cima (y=0)
        var tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
            // esse chain permite a combinação de interpolações
            .chain(curveTween);

        // esse widget faz a transição do child ser do tipo slide
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route<Object?> _createRoute2() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          Page2(title: "route 2"),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // mesma animação acima, porém codificado de maneira diferente
        var tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  Route<Object?> _createRoute3() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          Page2(title: "route 3"),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.decelerate,
        );

        return RotationTransition(
          turns: curvedAnimation,
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}

class Page2 extends StatelessWidget {
  final String title;

  Page2({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
