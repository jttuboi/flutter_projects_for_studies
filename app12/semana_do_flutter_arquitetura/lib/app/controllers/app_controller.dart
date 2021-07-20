import 'package:flutter/foundation.dart';

class AppController {
  // construtor privado
  AppController._();

  // transformando essa classe em singleton
  static final AppController instance = AppController._();

  final themeSwitch = ValueNotifier<bool>(false);

  changeTheme(bool value) {
    // no momento que essa variavel for alterada, ela atualizará quem utiliza essa variavel
    themeSwitch.value = value;
  }
}
