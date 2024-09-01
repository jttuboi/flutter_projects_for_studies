import 'package:flutter/material.dart';

import '../utils/route_name.dart';

Future<void> showMyDialog(BuildContext context, RouteName route) async {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: route.color,
          content: Text(route.name),
          actions: [
            ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Fechar')),
          ],
        );
      });
}
