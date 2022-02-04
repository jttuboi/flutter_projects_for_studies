import 'package:flutter/material.dart';
import 'package:manguinho/ui/components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            Headline1('LOGIN'),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Senha', icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight)),
                      obscureText: true,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(onPressed: () {}, child: Text('Entrar')),
                    TextButton.icon(onPressed: () {}, icon: Icon(Icons.person), label: Text('Criar conta')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
