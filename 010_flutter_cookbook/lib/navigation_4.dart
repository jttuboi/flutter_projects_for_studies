import 'package:flutter/material.dart';

class Navigation4Routes {
  static const String extract_screen = "/navigation_4_extract_screen";
  static const String extract2_screen = "/navigation_4_extract_2_screen";
}

class Navigation4 extends StatelessWidget {
  const Navigation4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Navigation4Routes.extract_screen,
                arguments: ScreenArguments(
                  'Recuperar pelo ModalRoute',
                  'msg recuperada no ModalRoute',
                ),
              ),
              child: Text('recuperação via ModalRoute'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Navigation4Routes.extract2_screen,
                arguments: ScreenArguments(
                  'Recuperar pelo onGenerateRoute',
                  'msg recuperada no onGenerateRoute',
                ),
              ),
              child: Text('recuperação via onGenerateRoute'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("extração pelo ModalRoute"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("os dados vieram da Navigation4()"),
            Text("e está sendo recuperado por: "),
            Text("ModalRoute.of(context)!.settings.arguments"),
            Text("title: ${args.title}"),
            Text("msg: ${args.message}"),
          ],
        ),
      ),
    );
  }
}

class PassArgumentsScreen extends StatelessWidget {
  final String title;
  final String message;

  const PassArgumentsScreen({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("extração no onGenerateRoute"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("os dados vieram da Navigation4()"),
            Text("e está sendo recuperado dentro do: "),
            Text("MaterialApp::onGenerateRoute"),
            Text("title: $title"),
            Text("msg: $message"),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
