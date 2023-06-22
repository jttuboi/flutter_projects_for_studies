import 'package:cliente/api_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final c1 = TextEditingController();
  final c2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acessar')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: c1,
                decoration: const InputDecoration(hintText: 'Usuário'),
                keyboardType: TextInputType.name,
              ),
              TextField(
                controller: c2,
                obscuringCharacter: '*',
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Senha'),
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: () async {
                  // validação de forms
                  var user = await ApiService.login(c1.text, c2.text);
                  if (user.authenticated) {
                    _goHomePage(context);
                  } else {
                    _alert(context, 'usuario invalido');
                  }
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goHomePage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  void _alert(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body: Center(
        child: FutureBuilder(
          future: ApiService.fetchTodos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('LOADING');
            }
            if (snapshot.hasError) {
              return const Text('ERROR');
            }
            return Text('${snapshot.data}');
          },
        ),
      ),
    );
  }
}
