import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LOGIN_KEY = '5FD6G46SDF4GD64F1VG9SD68';
const ONBOARD_KEY = 'GD2G82CG9G82VDFGVD22DVG';

// esta classe que controla o estado do app
// aqui que decide se está logado ou não
class AppService with ChangeNotifier {
  AppService(this.sharedPreferences);

  late final SharedPreferences sharedPreferences;
  bool _loginState = false;
  bool _initialized = false;
  bool _onboarding = false;

  bool get loginState => _loginState;
  bool get initialized => _initialized;
  bool get onboarding => _onboarding;

  set loginState(bool state) {
    sharedPreferences.setBool(LOGIN_KEY, state);
    _loginState = state;
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  set onboarding(bool value) {
    sharedPreferences.setBool(ONBOARD_KEY, value);
    _onboarding = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    // seta o inicio de acordo com a situação anterior, o usuario já podia estar logado antes de ter fechado e aberto o app
    // TODO e ... onborading== integração??? o que é onboarding?
    _onboarding = sharedPreferences.getBool(ONBOARD_KEY) ?? false;
    _loginState = sharedPreferences.getBool(LOGIN_KEY) ?? false;

    // apenas para mostrar o splash page funfando
    await Future.delayed(const Duration(seconds: 2));

    // talvez aqui esteja também os loading do injector
    // esse é o momento que todos as classes essenciais para o funcionamento do app são inicializados

    _initialized = true;
    notifyListeners();
  }
}
