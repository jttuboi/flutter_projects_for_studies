import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:raywenderlich/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState extends ChangeNotifier {
  LoginState(this.prefs) {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
  }

  final SharedPreferences prefs;
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    prefs.setBool(loggedInKey, value);
    log('CHange notifier::loggedIn = $loggedIn ');
    notifyListeners();
  }

  void checkLoggedIn() {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
  }
}
