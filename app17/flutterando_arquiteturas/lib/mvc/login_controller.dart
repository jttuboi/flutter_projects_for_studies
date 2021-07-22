import 'package:flutter/material.dart';
import 'package:flutterando_arquiteturas/mvc/login_repository.dart';
import 'package:flutterando_arquiteturas/mvc/user_model.dart';

class LoginController {
  LoginController(this.repository);

  final LoginRepository repository;

  final UserModel _model = UserModel();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void userEmail(String? value) => _model.email = value!;
  void userPassword(String? value) => _model.password = value!;

  Future<bool> login() async {
    // chama os validator() dos TextFormField()
    if (!formKey.currentState!.validate()) {
      return false;
    }
    // chama os onSaved() dos TextFormField()
    formKey.currentState!.save();

    try {
      return await repository.doLogin(_model);
    } catch (e) {
      return false;
    }
  }
}
