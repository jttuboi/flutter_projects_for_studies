import 'package:flutter/material.dart';
import 'package:flutterando_arquiteturas/home_page.dart';
import 'package:flutterando_arquiteturas/mvvm/login_repository.dart';
import 'package:flutterando_arquiteturas/mvvm/login_viewmodel.dart';
import 'package:flutterando_arquiteturas/mvvm/user_model.dart';

class LoginPageMVVM extends StatefulWidget {
  @override
  _LoginPageMVVMState createState() => _LoginPageMVVMState();
}

class _LoginPageMVVMState extends State<LoginPageMVVM> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late PageViewModel _viewModel;
  final UserModel _model = UserModel();

  @override
  void initState() {
    super.initState();
    _viewModel = PageViewModel(repository: LoginRepository());
    _viewModel.isLoginOut.listen((isLogin) {
      if (isLogin) {
        _loginSuccess();
      } else {
        _loginError();
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
        key: _formKey,
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
                onSaved: (newValue) => _model.email = newValue!,
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
                onSaved: (newValue) => _model.password = newValue!,
              ),
              SizedBox(height: 30),
              StreamBuilder<bool>(
                  stream: _viewModel.isLoadingOut,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool isLoading = snapshot.data!;

                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              // chama os validator() dos TextFormField()
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              // chama os onSaved() dos TextFormField()
                              _formKey.currentState!.save();
                              _viewModel.isLoginIn.add(_model);
                            },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80.0),
                        child: Text('ENTER'),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
