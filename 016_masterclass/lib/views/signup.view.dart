import 'package:flutter/material.dart';
import 'package:masterclass/controllers/signup.controller.dart';
import 'package:masterclass/models/user.model.dart';
import 'package:masterclass/repositories/account.repository.dart';
import 'package:masterclass/stores/app.store.dart';
import 'package:masterclass/view_models/signup.viewmodel.dart';
import 'package:masterclass/views/home.view.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignupController _controller = SignupController(AccountRepository());
  SignupViewModel _viewModel = SignupViewModel();

  @override
  Widget build(BuildContext context) {
    final AppStore _store = Provider.of<AppStore>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Cadastre-se'),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome inválido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    _viewModel.name = newValue!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    _viewModel.email = newValue!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Senha inválida';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    _viewModel.password = newValue!;
                  },
                ),
                const SizedBox(height: 20),
                if (_viewModel.busy)
                  const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      setState(() {});
                      //print(_viewModel);
                      _controller.create(_viewModel).then((UserModel value) {
                        //print(value);

                        setState(() {});
                        _store.setUser(
                          value.name,
                          value.email,
                          value.picture,
                          value.token,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeView(),
                          ),
                        );
                      });
                    },
                    child: const Text('Cadastrar'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
