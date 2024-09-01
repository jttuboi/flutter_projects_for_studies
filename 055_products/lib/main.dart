import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:products/domain/dependency_injection.dart';
// ignore: unused_import
import 'package:products/fill_database.dart';

import 'package:products/presentation/android_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpDependencyInjections();

  // ignore: todo
  // TODO usado para preencher o Firebase com dados iniciais para teste
  // sempre descomentar na primeira vez apenas. Após isso, só descomentar quando for renovar a base.
  //await fillDatabase();

  runApp(const AndroidApp());
}
