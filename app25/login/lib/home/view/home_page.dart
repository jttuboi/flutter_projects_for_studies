import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/authentication/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              // acessa os dados (user id) do bloc via select (os dados não sao salvos no bloc e sim no estado atual)
              final userId = context.select((AuthenticationBloc bloc) => bloc.state.user.id);
              return Text('UserID: $userId');
            }),
            ElevatedButton(
              // cria o evento de logout
              onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
