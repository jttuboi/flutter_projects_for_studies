import 'package:flutter/material.dart';

class CIconButton extends StatelessWidget {
  const CIconButton({required this.icon, this.onPressed, super.key});

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
