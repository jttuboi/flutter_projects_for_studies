import 'package:flutter/material.dart';

class App1 extends StatelessWidget {
  const App1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(
        routerDelegate: MyRouterDelegate(),
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
// ROUTER DELEGATE
///////////////////////////////////////////////////////////////////////////////
///
class MyRouterDelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  // navigatorKey que é uma chave para se referir ao nosso navigator.
  // Ele é usado pelo PopNavigatorRouterDelegateMixin
  // e você pode usá-lo para navegar de maneira imperativa (embora você nunca deva precisar)
  final GlobalKey<NavigatorState> navigatorKey;

  bool showOtherPage = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      // pages é a pilha de páginas que descreve nossa pilha de navegação de maneira declarativa.
      // Observe que não usamos diretamente o widget, mas sim MaterialPage.
      // Neste ponto você não deve se preocupar com isso, mas saiba que MaterialPage descreve,
      // por exemplo, a transição entre diferentes rotas.
      // Observe também que o parâmetro key deve ser usado para animar corretamente entre as páginas.
      pages: [
        MaterialPage(
          key: ValueKey('MyHomePage'),
          child: MyHomeScreen(
            onPressed: () {
              showOtherPage = true;
              notifyListeners();
            },
          ),
        ),
        if (showOtherPage)
          MaterialPage(
            key: ValueKey('MyOtherPage'),
            child: MyOtherScreen(),
          ),
      ],
      // onPopPage é onde você deve alterar seu estado interno para refletir o pop
      // (se route.didPop(resultado) retornar true).
      // No nosso caso, definimos showOtherPage como false.
      onPopPage: (route, result) {
        final didPop = route.didPop(result);

        if (didPop) {
          showOtherPage = false;
        }

        return didPop;
      },
    );
  }

  // We don't use named navigation so we don't use this
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}

///////////////////////////////////////////////////////////////////////////////
// SCREENS
///////////////////////////////////////////////////////////////////////////////

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({required this.onPressed, Key? key}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 2.0 101 - Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPressed,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.greenAccent,
                child: Text('Click me to navigate.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyOtherScreen extends StatelessWidget {
  const MyOtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 2.0 101 - Other page')),
      body: Center(
        child: Text('You did it!'),
      ),
    );
  }
}
