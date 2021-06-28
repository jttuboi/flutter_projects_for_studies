import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Page1()));

// página inicial com 1 botão
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          // normalmente utiliza o routes do MaterialApp, passando todas as rotas
          // de cada página. Então no Navigator, utiliza-se o pushNamed para
          // indicar qual rota ele deve seguir.

          // chama a rota animada
          onPressed: () => Navigator.of(context).push(_createRoute()),
          child: Text("Go to 2!"),
        ),
      ),
    );
  }

  // rota animada
  Route<Object?> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // cria a interpolação da animação no formato de curva
        // o ease faz a animação inicial ser rápida e próximo ao fim vai devagar
        var curveTween = CurveTween(curve: Curves.ease);

        // cria a interpolação da animação
        // esse tween faz com que a Page2 apareça debaixo (y=1) para cima (y=0)
        var tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
            // esse chain permite a combinação de interpolações
            .chain(curveTween);

        // esse widget faz a transição da tela ser do tipo slide
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

// página inicial com texto
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          // normalmente utiliza o routes do MaterialApp, passando todas as rotas
          // de cada página. Então no Navigator, utiliza-se o pushNamed para
          // indicar qual rota ele deve seguir.

          // chama a rota animada
          onPressed: () => Navigator.of(context).push(_createRoute()),
          child: Text("Go to 3!"),
        ),
      ),
    );
  }

  // rota animada
  Route<Object?> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page3(),
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
}

// página inicial com texto
class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("3!"),
      ),
    );
  }
}
