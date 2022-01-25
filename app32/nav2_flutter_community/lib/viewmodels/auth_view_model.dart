// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/data/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this.authRepository);

  final AuthRepository? authRepository;
  bool _logingIn = false;
  bool _logingOut = false;

  Future<bool> login() async {
    _logingIn = true;
    notifyListeners();
    final result = await authRepository!.login();
    _logingIn = false;
    notifyListeners();
    return result;
  }

  Future<bool> logout() async {
    _logingOut = true;
    notifyListeners();
    final logoutResult = await authRepository!.logout();
    _logingOut = false;
    notifyListeners();
    return logoutResult;
  }
}
