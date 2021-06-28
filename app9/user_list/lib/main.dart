import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list/provider/users.dart';
import 'package:user_list/routes/app_routes.dart';
import 'package:user_list/views/user_form.dart';
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
        routes: {
          AppRoutes.HOME: (_) => UserList(title: 'User List'),
          AppRoutes.USER_FORM: (_) => UserForm(),
        },
      ),
    );
  }
}
