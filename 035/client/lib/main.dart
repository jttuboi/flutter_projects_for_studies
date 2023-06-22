import 'package:client/api_service.dart';
import 'package:client/controller.dart';
import 'package:client/storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final IController _controller = Controller(HttpApiService(), SecureStorage());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
          future: _controller.logged,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            if (snapshot.data!) {
              return HomePage(_controller);
            }
            return LoginPage(_controller);
          }),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage(this.controller, {Key? key}) : super(key: key);

  final IController controller;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                obscuringCharacter: '*',
                keyboardType: TextInputType.text,
              ),
              Row(
                children: [
                  TextButton(onPressed: _login, child: Text('Log In')),
                  TextButton(onPressed: _signup, child: Text('Sign Up')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    var username = _usernameController.text;
    var password = _passwordController.text;

    var logged = await widget.controller.login(username, password);

    if (!mounted) {
      return;
    }

    if (logged) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return HomePage(widget.controller);
        },
      ));
    } else {
      displayDialog(context, 'An Error Occurred',
          'No account was found matching that username and password');
    }
  }

  void _signup() async {
    var username = _usernameController.text;
    var password = _passwordController.text;

    if (username.length < 4) {
      displayDialog(context, 'Invalid Username',
          'The username should be at least 4 characters long');
    } else if (password.length < 4) {
      displayDialog(context, 'Invalid Password',
          'The password should be at least 4 characters long');
    } else {
      var response = await widget.controller.signup(username, password);
      if (response == 201) {
        displayDialog(context, 'Success', 'The user was created. Log in now.');
      } else if (response == 409) {
        displayDialog(context, 'That username is already registered',
            'Please try to sign up using another username or log in if you already have an account.');
      } else {
        displayDialog(context, 'Error', 'An unknown error occurred.');
      }
    }
  }

  void displayDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text(title), content: Text(text));
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage(this.controller, {Key? key}) : super(key: key);

  final IController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secret Data Page')),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
            future: controller.getHomeViewModel(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Text('An error occurred');
              }

              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final data = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${data['username']}, here s the data:'),
                  Text(data['data'], style: TextStyle(fontSize: 20)),
                ],
              );
            }),
      ),
    );
  }
}
