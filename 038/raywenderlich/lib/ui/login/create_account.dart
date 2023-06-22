import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raywenderlich/constants.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';
import 'package:raywenderlich/widgets/j_elevated_button.dart';
import 'package:raywenderlich/widgets/j_text_form_field.dart';
import 'package:go_router/go_router.dart';

import '../../login_state.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(title: 'Create Account'),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JTextFormField(hintText: 'Email', controller: emailTextController),
                JTextFormField(
                  hintText: 'Password',
                  controller: passwordTextController,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                ),
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
                        onPressed: () async => saveLoginState(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: JElevatedButton(
                        title: 'Cancel',
                        style: JElevatedButtonStyle.white,
                        onPressed: () => context.goNamed(loginRouteName),
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
    // TODO transformar num metodo para evitar "setar" o valor fora do LoginState
    Provider.of<LoginState>(context, listen: false).loggedIn = true;
  }
}
