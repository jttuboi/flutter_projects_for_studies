import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/data/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this.authRepository);

  final AuthRepository? authRepository;
  bool logingIn = false;
  bool logingOut = false;

  Future<bool> login() async {
    logingIn = true;
    notifyListeners();
    final result = await authRepository!.login();
    logingIn = false;
    notifyListeners();
    return result;
  }

  Future<bool> logout() async {
    logingOut = true;
    notifyListeners();
    final logoutResult = await authRepository!.logout();
    logingOut = false;
    notifyListeners();
    return logoutResult;
  }
}
