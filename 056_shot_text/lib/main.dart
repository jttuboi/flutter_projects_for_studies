import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shot_text/app_module.dart';
import 'package:shot_text/app_widget_android.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidgetAndroid()));
}
