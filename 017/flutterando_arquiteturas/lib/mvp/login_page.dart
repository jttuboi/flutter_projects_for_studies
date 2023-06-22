import 'package:flutter/material.dart';
import 'package:flutterando_arquiteturas/home_page.dart';
import 'package:flutterando_arquiteturas/mvp/login_repository.dart';
import 'package:flutterando_arquiteturas/mvp/login_presenter.dart';

class LoginPageMVP extends StatefulWidget {
  @override
  _LoginPageMVPState createState() => _LoginPageMVPState();
}

class _LoginPageMVPState extends State<LoginPageMVP>
    implements LoginPageContract {
  late LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this, repository: LoginRepository());
  }

  @override
  void loginSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  void loginError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Login error'),
      backgroundColor: Colors.red,
    ));
  }

  @override
  void loginManager() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _presenter.formKey,
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
                onSaved: _presenter.userEmail,
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
                onSaved: _presenter.userPassword,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _presenter.isLoading ? null : _presenter.login,
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
