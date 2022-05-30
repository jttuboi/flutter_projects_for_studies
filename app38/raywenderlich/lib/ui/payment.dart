import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';
import 'package:raywenderlich/widgets/j_elevated_button.dart';
import 'package:raywenderlich/widgets/j_text_field.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController creditCardController = MaskedTextController(mask: '0000 0000 0000 0000');
    final TextEditingController cvcController = MaskedTextController(mask: '000');
    final TextEditingController expirationController = MaskedTextController(mask: '00/00');

    return Scaffold(
      appBar: JAppBar(title: 'Payment'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JTextField(hintText: 'Credit Card', controller: creditCardController),
            const SizedBox(height: 16),
            JTextField(hintText: 'Expiration Date', controller: expirationController, keyboardType: TextInputType.number, maxLength: 5),
            const SizedBox(height: 16),
            JTextField(hintText: 'CVC', controller: cvcController, keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: JElevatedButton(
                title: 'Update',
                style: JElevatedButtonStyle.primaryColor,
                textStyle: JElevatedButtonTextStyle.white,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
