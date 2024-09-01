import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  const CButton(this.label, {this.onPressed, super.key}) : icon = Icons.abc;

  const CButton.icon(this.icon, {this.onPressed, super.key}) : label = '';

  final String label;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: TextButton(
        style: ButtonStyle(
          textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 12)),
          padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
          backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return Colors.blue;
          }),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          iconColor: const MaterialStatePropertyAll(Colors.white),
        ),
        onPressed: onPressed,
        child: hasIcon ? Text(label) : Icon(icon),
      ),
    );
  }

  bool get hasIcon => icon == Icons.abc;
}
