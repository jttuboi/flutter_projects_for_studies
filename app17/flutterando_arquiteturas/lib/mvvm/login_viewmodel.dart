import 'dart:async';

import 'package:flutterando_arquiteturas/mvvm/login_repository.dart';
import 'package:flutterando_arquiteturas/mvvm/user_model.dart';

class PageViewModel {
  PageViewModel({required this.repository});

  final LoginRepository repository;

  // o $ no final da variável é apenas uma representação de um fluxo
  // não é obrigatório
  // o StreamController é uma API para controle de fluxo de entrada e saída de dados
  final _isLoading$ = StreamController<bool>();

  Sink<bool> get isLoadingIn => _isLoading$.sink;
  Stream<bool> get isLoadingOut => _isLoading$.stream;

  final _isLogin$ = StreamController<UserModel>();
  Sink<UserModel> get isLoginIn => _isLogin$.sink;
  Stream<bool> get isLoginOut => _isLogin$.stream.asyncMap(login);

  Future<bool> login(UserModel model) async {
    bool isLogin;
    isLoadingIn.add(true);

    try {
      isLogin = await repository.doLogin(model);
    } catch (e) {
      isLogin = false;
    }

    isLoadingIn.add(false);

    return isLogin;
  }

  // SEMPRE executar o close() do StreamController() após não houver mais a necessidade de uso
  // senão pode causar problemas de acesso indevido e vazamento de memória
  dispose() {
    _isLoading$.close();
    _isLogin$.close();
  }
}
