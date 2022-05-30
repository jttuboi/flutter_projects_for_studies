import 'package:flutter/material.dart';

class JTextFormField extends StatelessWidget {
  const JTextFormField({required this.hintText, this.controller, this.enableSuggestions = true, this.autocorrect = true, this.obscureText = false, Key? key}) : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              enableSuggestions: enableSuggestions,
              autocorrect: autocorrect,
              obscureText: obscureText,
              decoration: InputDecoration(border: UnderlineInputBorder(), hintText: hintText),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
