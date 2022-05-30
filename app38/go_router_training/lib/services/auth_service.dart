import 'dart:async';

// aqui controla como o usuário está logando
class AuthService {
  final StreamController<bool> _onAuthStateChange = StreamController.broadcast();

  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  Future<bool> login() async {
    // apenas para simular o login com o servidor
    await Future.delayed(const Duration(seconds: 1));

    _onAuthStateChange.add(true);
    return true;
  }

  void logOut() {
    _onAuthStateChange.add(false);
  }
}
