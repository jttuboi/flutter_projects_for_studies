import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

extension AutthenticationStatusExtension on AuthenticationStatus {
  bool get isUnknown => this == AuthenticationStatus.unknown;
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
  bool get isUnauthenticated => this == AuthenticationStatus.unauthenticated;
}

class AuthenticationRepository {
  // é o controller de apenas 1 subscriber (apenas 1 pode ouvir, se quiser mais, precisa utilizar o .asBroadcastStream())
  // serve para emitir eventos assincronos e avisar quando estiver pronto
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    // simula o request do status para um servidor
    await Future<void>.delayed(const Duration(seconds: 1));
    // retorna como se nao tivesse autenticado (usado apenas para teste, pois pode ser autenticado)
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({required String username, required String password}) async {
    // simula o request do log in para um servidor
    await Future.delayed(
      const Duration(milliseconds: 300),
      // diz para o controller que autenticou
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  // tem que chamar quando clicar para deslogar ou quando sai do app
  void logOut() {
    // diz para o controller que deslogou
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  // quando fecha o app
  void dispose() {
    _controller.close();
  }
}
