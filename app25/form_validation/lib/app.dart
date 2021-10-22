import 'package:flutter/material.dart';
import 'package:form_validation/form_validation/views/form_validation_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FormValidationPage(),
    );
  }
}
