import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/screens/login_screen.dart';

class LoginPage extends Page {
  LoginPage({required this.onLogin}) : super(key: ValueKey('LoginPage'));

  final VoidCallback onLogin;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => LoginScreen(onLogin: onLogin),
    );
  }
}
