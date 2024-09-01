import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:person_form/views/android_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AndroidApp());
}
