import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/router/my_app_router_delegate.dart';

// https://medium.com/flutter-community/flutter-navigator-2-0-for-authentication-and-bootstrapping-part-1-introduction-d7b6dfdd0849

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // delegate, ele quem gerencia todas as rotas,
  // decidindo o conjunto de pages que deverá permanecer na stack
  final _delegate = MyAppRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // o Router é o Widget "provider" e o delegate é o controller
      home: Router(
        routerDelegate: _delegate,
        // quando aperta o botão voltar do androidOS, ele sai do app.
        // para isso deve incluir esse RootBackButtonDispatcher().
        // ele é um dispatcher padrão para o botão voltar,
        // cujo redireciona para a mesma ação do voltar do app,
        // que acontece no onPopPage do delegate.
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
