import 'package:flutter/material.dart';

class JTextField extends StatelessWidget {
  const JTextField({required this.hintText, this.controller, this.keyboardType, this.maxLength, Key? key}) : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLength: maxLength,
              keyboardType: keyboardType,
              decoration: InputDecoration(border: UnderlineInputBorder(), hintText: hintText),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
