import 'package:flutter/material.dart';

class JAppBar extends AppBar {
  JAppBar({required String title})
      : super(
          elevation: 0,
          backgroundColor: Colors.lightBlue,
          title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
        );
}
