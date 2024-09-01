import 'package:flutter/material.dart';

/// TODO talvez nem precisa usar change notifier, já que não há algum AnimatedBuilder para ser atualizado
class AuthenticationChangeNotifier extends ChangeNotifier {
  AuthenticationChangeNotifier();

  bool isLogged = false;
  String userLogged = '';
  bool wToAnwser = false;
  //bool wToAnwser = true;

  Future<void> login() async {
    isLogged = true;
    userLogged = 'XXX';
    print('AuthenticationChangeNotifier.login()');
    print('AuthenticationChangeNotifier.isLogged = true');
    notifyListeners();
  }

  Future<void> logout() async {
    isLogged = false;
    userLogged = '';
    print('AuthenticationChangeNotifier.logout()');
    print('AuthenticationChangeNotifier.isLogged = false');
    notifyListeners();
  }

  Future<void> wFinished() async {
    wToAnwser = false;
  }
}
