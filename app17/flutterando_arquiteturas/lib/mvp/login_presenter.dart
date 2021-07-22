import 'package:flutter/material.dart';
import 'package:flutterando_arquiteturas/mvp/login_repository.dart';
import 'package:flutterando_arquiteturas/mvp/user_model.dart';

abstract class LoginPageContract {
  void loginSuccess();
  void loginError();
  void loginManager();
}

class LoginPresenter {
  LoginPresenter(this.viewContract, {required this.repository});

  final LoginPageContract viewContract;
  final LoginRepository repository;

  final UserModel _model = UserModel();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void userEmail(String? value) => _model.email = value!;
  void userPassword(String? value) => _model.password = value!;

  void login() async {
    bool isLogin;
    isLoading = true;
    viewContract.loginManager();

    // chama os validator() dos TextFormField()
    if (!formKey.currentState!.validate()) {
      isLogin = false;
    } else {
      // chama os onSaved() dos TextFormField()
      formKey.currentState!.save();

      try {
        isLogin = await repository.doLogin(_model);
      } catch (e) {
        isLogin = false;
      }
    }

    isLoading = false;
    viewContract.loginManager();

    if (isLogin) {
      viewContract.loginSuccess();
    } else {
      viewContract.loginError();
    }
  }
}
