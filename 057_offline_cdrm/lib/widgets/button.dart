import 'package:flutter/material.dart';

import '../utils/route_name.dart';

class Button extends StatelessWidget {
  Button.route(RouteName route, {this.onTap, super.key})
      : label = route.name,
        color = route.color;

  const Button.label(this.label, {this.color = Colors.white, this.onTap, super.key});

  final String label;
  final Color color;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: (onTap == null) ? const MaterialStatePropertyAll(Colors.grey) : MaterialStatePropertyAll(color)),
      onPressed: onTap,
      child: Text(label),
    );
  }
}
