import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  const CTextField({required this.title, required this.validationMessageError, required this.textController, super.key});

  final String title;
  final String? validationMessageError;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      decoration: InputDecoration(
        label: Text(title),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        errorText: validationMessageError,
      ),
      controller: textController,
    );
  }
}
