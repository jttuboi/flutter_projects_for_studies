import 'dart:async';

import 'package:flutter/material.dart';

import 'features/contacts/contacts_screen.dart';
import 'utils/registers.dart';
import 'utils/strings.dart';

Future<void> main() async {
  await registers();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.title,
      home: ContactsScreen(),
    );
  }
}
