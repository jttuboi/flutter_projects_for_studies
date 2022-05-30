import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';
import 'package:raywenderlich/widgets/j_elevated_button.dart';
import 'package:raywenderlich/widgets/j_text_form_field.dart';

import '../../login_state.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(title: 'Login'),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JTextFormField(hintText: 'Email', controller: emailTextController),
                JTextFormField(hintText: 'Email', controller: emailTextController),
                JTextFormField(hintText: 'Password', controller: passwordTextController, enableSuggestions: false, autocorrect: false, obscureText: true),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: JElevatedButton(
                        title: 'Create Account',
                        style: JElevatedButtonStyle.primaryColor,
                        textStyle: JElevatedButtonTextStyle.white,
                        onPressed: () {
                          // TODO: Add Create Account Route
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: JElevatedButton(
                        title: 'Login',
                        style: JElevatedButtonStyle.white,
                        onPressed: () {
                          saveLoginState(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveLoginState(BuildContext context) {
    Provider.of<LoginState>(context, listen: false).loggedIn = true;
  }
}
