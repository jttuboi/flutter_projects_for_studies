import 'package:mobx/mobx.dart';
part 'app.store.g.dart';

// para gerar o código g. precisa executar
// flutter packages pub run build_runner clean
// flutter packages pub run build_runner build

class AppStore = _AppStore with _$AppStore;

// toda vez que alguém ler alguma variavel daqui, aquele local irá ficar conectado com store
// aí toda vez essa variavel daqui for atualizada, irá refletir no local conectado, não precisando atualizar o Widget pelo setState
abstract class _AppStore with Store {
  @observable
  String name = '';
  @observable
  String email = '';
  @observable
  String picture = 'https://placehold.it/200';
  @observable
  String token = '';

  @action
  void setUser(
    String pName,
    String pEmail,
    String pPicture,
    String pToken,
  ) {
    name = pName;
    email = pEmail;
    picture = pPicture;
    token = pToken;
  }
}
