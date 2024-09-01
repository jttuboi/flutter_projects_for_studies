import 'package:flutter/material.dart';
import 'package:shot_text/presentation/camera_shot/theme.dart';

class ShotIconButton extends StatelessWidget {
  const ShotIconButton({required this.tooltip, required this.icon, required this.onPressed, Key? key}) : super(key: key);

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: TextButton(onPressed: onPressed, style: iconButtonStyle, child: Icon(icon, size: 40)),
    );
  }
}
