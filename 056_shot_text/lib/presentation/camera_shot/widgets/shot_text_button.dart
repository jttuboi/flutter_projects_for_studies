import 'package:flutter/material.dart';
import 'package:shot_text/presentation/camera_shot/theme.dart';

class ShotTextButton extends StatelessWidget {
  const ShotTextButton({required this.text, required this.onPressed, Key? key}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: textButtonStyle,
      child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
    );
  }
}
