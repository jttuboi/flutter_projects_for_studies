import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/common/cache/preference.dart';
import 'package:nav2_flutter_community/data/auth_repository.dart';
import 'package:nav2_flutter_community/data/colors_repository.dart';
import 'package:nav2_flutter_community/router/my_app_route_information_parser.dart';
import 'package:nav2_flutter_community/router/my_app_router_delegate.dart';
import 'package:nav2_flutter_community/viewmodels/auth_view_model.dart';
import 'package:nav2_flutter_community/viewmodels/colors_view_model.dart';
import 'package:provider/provider.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

// https://medium.com/flutter-community/flutter-navigator-2-0-for-authentication-and-bootstrapping-part-1-introduction-d7b6dfdd0849

void main() {
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // delegate, ele quem gerencia todas as rotas,
  // decidindo o conjunto de pages que deverá permanecer na stack
  late MyAppRouterDelegate _delegate;
  // parser para converter path "mobile" em path web (urls) e vice-versa
  late MyAppRouteInformationParser _parser;
  late AuthRepository _authRepository;
  late ColorsRepository _colorsRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(Preference());
    _colorsRepository = ColorsRepository();
    _delegate = MyAppRouterDelegate(_authRepository, _colorsRepository);
    _parser = MyAppRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(_authRepository),
        ),
        ChangeNotifierProvider<ColorsViewModel>(
          create: (_) => ColorsViewModel(_colorsRepository),
        ),
      ],
      // child: MaterialApp(
      //   // o Router é o Widget "provider" e o delegate é o "change notifier"
      //   home: Router(
      //     routerDelegate: _delegate,
      //     // voltado principalmente para parte web
      //     routeInformationParser: _parser,
      //     // quando aperta o botão voltar do androidOS, ele sai do app.
      //     // para isso deve incluir esse RootBackButtonDispatcher().
      //     // ele é um dispatcher padrão para o botão voltar,
      //     // cujo redireciona para a mesma ação do voltar do app,
      //     // que acontece no onPopPage do delegate.
      //     backButtonDispatcher: RootBackButtonDispatcher(),
      //   ),
      // ),

      child: MaterialApp.router(
        routerDelegate: _delegate,
        routeInformationParser: _parser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
