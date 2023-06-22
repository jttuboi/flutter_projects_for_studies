import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/login/bloc/login_bloc.dart';
import 'package:login/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
