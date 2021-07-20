import 'package:flutter/material.dart';
import 'package:semana_do_flutter_arquitetura/app/controllers/app_controller.dart';
import 'package:semana_do_flutter_arquitetura/app/pages/home/home_page.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // o ValueListenableBuilder faz a conexão com o AppController através do valueListenable
    return ValueListenableBuilder(
      valueListenable: AppController.instance.themeSwitch,
      builder: (context, bool isDark, child) {
        return MaterialApp(
          title: "Semana Flutter",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: isDark ? Brightness.dark : Brightness.light,
          ),
          home: HomePage(),
        );
      },
    );
  }
}
