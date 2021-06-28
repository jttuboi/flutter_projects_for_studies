import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list/provider/users.dart';
import 'package:user_list/views/user_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Users(),
        ),
      ],
      child: MaterialApp(
        title: 'User List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserList(title: 'User List'),
      ),
    );
  }
}
