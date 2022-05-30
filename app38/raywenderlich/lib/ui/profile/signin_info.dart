import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';
import 'package:raywenderlich/widgets/j_elevated_button.dart';
import 'package:raywenderlich/widgets/j_text_field.dart';

import '../../login_state.dart';

class SigninInfo extends StatefulWidget {
  const SigninInfo({Key? key}) : super(key: key);

  @override
  _SigninInfoState createState() => _SigninInfoState();
}

class _SigninInfoState extends State<SigninInfo> {
  final password1TextController = TextEditingController();
  final password2TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(title: 'Signin Info'),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Change Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                ],
              ),
            ),
            JTextField(hintText: 'New Password', controller: password1TextController),
            JTextField(hintText: 'Type New Password Again', controller: password2TextController),
            JElevatedButton(
              title: 'Change Password',
              style: JElevatedButtonStyle.primaryColor,
              textStyle: JElevatedButtonTextStyle.white,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            JElevatedButton(
              title: 'Sign Out',
              style: JElevatedButtonStyle.primaryColor,
              textStyle: JElevatedButtonTextStyle.white,
              onPressed: () => saveLoginState(context),
            ),
          ],
        ),
      ),
    );
  }

  void saveLoginState(BuildContext context) {
    Provider.of<LoginState>(context, listen: false).loggedIn = false;
  }
}
