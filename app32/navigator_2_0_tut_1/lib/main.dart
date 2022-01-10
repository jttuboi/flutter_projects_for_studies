import 'package:flutter/material.dart';
import 'package:navigator_2_0_tut_1/app_state.dart';
import 'package:navigator_2_0_tut_1/ui/splash_Page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    // TODO Setup Router & dispatcher
  }

  // TODO Create Delegate, Parser and Back button Dispatcher

  // TODO Add Subscription

  final appState = AppState();

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  void dispose() {
    // TODO Dispose of Subscription
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    // TODO Attach a listener to the Uri links stream
  }

  @override
  Widget build(BuildContext context) {
    // TODO Add Router
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: MaterialApp(
        title: 'Navigation App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
    );
  }
}
