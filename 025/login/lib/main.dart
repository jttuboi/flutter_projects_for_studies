import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:login/app.dart';
import 'package:user_repository/user_repository.dart';

void main() => runApp(App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ));
