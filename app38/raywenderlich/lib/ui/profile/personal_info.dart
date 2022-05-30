import 'package:flutter/material.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';
import 'package:raywenderlich/widgets/j_elevated_button.dart';
import 'package:raywenderlich/widgets/j_text_field.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    final nameTextController = TextEditingController();
    final addressTextController = TextEditingController();
    final cityTextController = TextEditingController();
    final stateTextController = TextEditingController();

    return Scaffold(
      appBar: JAppBar(title: 'Personal Info'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JTextField(hintText: 'Name', controller: nameTextController),
            const SizedBox(height: 16),
            JTextField(hintText: 'Address', controller: addressTextController),
            const SizedBox(height: 16),
            JTextField(hintText: 'City', controller: cityTextController),
            const SizedBox(height: 16),
            JTextField(hintText: 'State', controller: stateTextController),
            const SizedBox(height: 16),
            JElevatedButton(
              title: 'Update',
              style: JElevatedButtonStyle.primaryColor,
              textStyle: JElevatedButtonTextStyle.white,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
