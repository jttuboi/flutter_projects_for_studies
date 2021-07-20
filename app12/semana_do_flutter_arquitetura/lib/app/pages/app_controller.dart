import 'package:flutter/foundation.dart';
import 'package:semana_do_flutter_arquitetura/app/models/appconfig_model.dart';

class AppController {
  // construtor privado
  AppController._();

  // transformando essa classe em singleton
  static final AppController instance = AppController._();

  // variáveis para facilitar o acesso do valor no model passando pelo controller
  // evitando assim o acesso da view diretamente no model
  bool get isDark => config.themeSwitch.value;
  ValueNotifier<bool> get themeSwitch => config.themeSwitch;

  final AppConfigModel config = AppConfigModel();

  changeTheme(bool value) {
    // no momento que essa variavel for alterada, ela atualizará quem utiliza essa variavel
    config.themeSwitch.value = value;
  }
}
