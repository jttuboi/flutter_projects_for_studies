import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raywenderlich/cart_holder.dart';
import 'package:raywenderlich/login_state.dart';
import 'package:raywenderlich/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = LoginState(await SharedPreferences.getInstance());
  state.checkLoggedIn();
  runApp(App(loginState: state));
}

class App extends StatelessWidget {
  const App({required this.loginState, Key? key}) : super(key: key);

  final LoginState loginState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartHolder>(lazy: false, create: (_) => CartHolder()),
        ChangeNotifierProvider<LoginState>(lazy: false, create: (_) => loginState),
        Provider<MyRouter>(lazy: false, create: (_) => MyRouter(loginState)),
      ],
      child: Builder(builder: (BuildContext context) {
        final router = Provider.of<MyRouter>(context, listen: false).router;
        return MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
          title: 'Navigation App',
          theme: ThemeData(primarySwatch: Colors.blue),
        );
      }),
    );
  }
}
