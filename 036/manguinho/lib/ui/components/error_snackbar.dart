import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String messageError) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(messageError, textAlign: TextAlign.center),
    backgroundColor: Colors.red[900],
  ));
}
