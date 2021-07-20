import 'package:flutter/foundation.dart';
import 'package:semana_do_flutter_arquitetura/app/services/shared_local_storage_service.dart';
import 'package:semana_do_flutter_arquitetura/app/viewmodels/change_theme_viewmodel.dart';

// o Controller vai gerenciar a parte estrutural da página
// (inicializa, instancia, delega quem é quem)
class AppController {
  // construtor privado
  AppController._() {
    changeThemeViewModel.init();
  }

  // transformando essa classe em singleton
  static final AppController instance = AppController._();

  final ChangeThemeViewModel changeThemeViewModel =
      ChangeThemeViewModel(storage: SharedLocalStorageService());

  // variáveis para facilitar o acesso do valor no model passando pelo controller
  // evitando assim o acesso da view diretamente no model
  bool get isDark => changeThemeViewModel.config.themeSwitch.value;
  ValueNotifier<bool> get themeSwitch =>
      changeThemeViewModel.config.themeSwitch;
}
