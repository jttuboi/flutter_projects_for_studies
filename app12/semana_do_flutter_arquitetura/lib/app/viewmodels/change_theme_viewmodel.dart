import 'package:semana_do_flutter_arquitetura/app/services/local_storage_interface.dart';
import 'package:semana_do_flutter_arquitetura/app/models/appconfig_model.dart';

// o ViewModel é onde ficará as regras de negócio, assim deixando para o controller
// gerenciar a parte estrutural (inicializa, instancia, delega quem é quem)

// ele também pode ser chamado de gerenciador de estados, nesse caso ele gerenciará
// os estados da mudança de temas
class ChangeThemeViewModel {
  ChangeThemeViewModel({required this.storage});

  final ILocalStorage storage;
  final AppConfigModel config = AppConfigModel();

  Future init() async {
    await storage.get("isDark").then((value) {
      config.themeSwitch.value = (value != null) ? value : false;
    });
  }

  void changeTheme(bool value) {
    // no momento que essa variavel for alterada, ela atualizará quem utiliza essa variavel
    config.themeSwitch.value = value;
    storage.put("isDark", value);
  }
}
