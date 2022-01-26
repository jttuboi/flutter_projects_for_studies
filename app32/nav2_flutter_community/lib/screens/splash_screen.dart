import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key, required this.process}) : super(key: key);

  final String process;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Splash !!!!!\n\n$process',
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      )),
    );
  }
}
