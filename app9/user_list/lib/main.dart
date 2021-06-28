import 'package:flutter/material.dart';
import 'package:user_list/views/user_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(title: 'User List'),
    );
  }
}
