import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shot_text/presentation/camera_shot/theme.dart';

class AppWidgetAndroid extends StatelessWidget {
  const AppWidgetAndroid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme).modular(); //added by extension
  }
}
