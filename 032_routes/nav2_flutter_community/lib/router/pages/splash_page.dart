import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/screens/splash_screen.dart';

class SplashPage extends Page {
  SplashPage({required this.process}) : super(key: ValueKey('SplashPage$process'));

  final String process;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) {
        return SplashScreen(process: process);
      },
    );
  }
}
