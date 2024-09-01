import 'package:architectures/controllers/signup_controller.dart';
import 'package:architectures/stores/app_store.dart';
import 'package:architectures/view_models/signup_view_model.dart';
import 'package:architectures/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SignupController();
  var model = SignupViewModel();

  @override
  Widget build(BuildContext context) {
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
                  validator: (value) => (value!.isEmpty) ? 'Nome inválido' : null,
                  onSaved: (newValue) => model.name = newValue!,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) => (value!.isEmpty) ? 'E-mail inválido' : null,
                  onSaved: (newValue) => model.email = newValue!,
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
                  validator: (value) => (value!.isEmpty) ? 'Senha inválida' : null,
                  onSaved: (newValue) => model.password = newValue!,
                ),
                const SizedBox(height: 20),
                model.busy
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }

                          setState(() {});

                          _controller.create(model).then((data) {
                            print(data.role);
                            setState(() {});

                            var store = context.read<AppStore>();
                            store.setUser(
                              data.name,
                              data.email,
                              data.picture,
                              data.token,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeView()),
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
