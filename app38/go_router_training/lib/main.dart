import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_training/router/app_router.dart';
import 'package:go_router_training/services/app_service.dart';
import 'package:go_router_training/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(await SharedPreferences.getInstance()));
}

class App extends StatefulWidget {
  const App(this.sharedPreferences, {Key? key}) : super(key: key);

  final SharedPreferences sharedPreferences;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppService appService;
  late AuthService authService;
  late StreamSubscription<bool> authSubscription;

  @override
  void initState() {
    super.initState();
    appService = AppService(widget.sharedPreferences);
    authService = AuthService();
    authSubscription = authService.onAuthStateChange.listen(_onAuthStateChange);
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
        Provider<AuthService>(create: (_) => authService),
      ],
      // o Builder foi utilizado aqui para que pudesse recuperar o AppRouter dentro desse build()
      // sem a preocupação com o problema do Provider ainda não estar no context
      child: Builder(builder: (context2) {
        final goRouter = Provider.of<AppRouter>(context2, listen: false).router;
        return MaterialApp.router(
          title: "Router App",
          routeInformationParser: goRouter.routeInformationParser,
          routerDelegate: goRouter.routerDelegate,
        );
      }),
    );
  }

  void _onAuthStateChange(bool login) {
    appService.loginState = login;
  }
}
