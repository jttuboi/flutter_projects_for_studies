import 'package:flutter/material.dart';
import 'package:flutterando_arquiteturas/home_page.dart';
import 'package:flutterando_arquiteturas/mvc/login_controller.dart';
import 'package:flutterando_arquiteturas/mvc/login_repository.dart';
import 'package:flutterando_arquiteturas/mvc/user_model.dart';

class LoginPageMVC extends StatefulWidget {
  @override
  _LoginPageMVCState createState() => _LoginPageMVCState();
}

class _LoginPageMVCState extends State<LoginPageMVC> {
  late LoginController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = LoginController(LoginRepository());
  }

  void _loginSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _loginError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Login error'),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo não pdoe ser vazio';
                  } else if (!value.contains('@')) {
                    return 'Email não é válido';
                  }
                  return null;
                },
                onSaved: _controller.userEmail,
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo não pdoe ser vazio';
                  }
                  return null;
                },
                onSaved: _controller.userPassword,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });

                        if (await _controller.login()) {
                          _loginSuccess();
                        } else {
                          _loginError();
                        }

                        setState(() {
                          _isLoading = false;
                        });
                      },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: Text('ENTER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
