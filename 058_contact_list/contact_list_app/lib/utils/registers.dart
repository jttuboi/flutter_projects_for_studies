import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import '../repositories/contact_offline_datasource.dart';
import '../repositories/sqflite_contact_offline_datasource.dart';
import '../services/connection_checker/connection_checker.dart';
import 'constants.dart';
import 'logger.dart';

Future<void> registers() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.activateLogger = true;

  if (!GetIt.I.isRegistered<FlutterSecureStorage>()) {
    GetIt.I.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    ));
  }

  if (!GetIt.I.isRegistered<IMyConnectionChecker>()) {
    GetIt.I.registerSingleton<IMyConnectionChecker>(MyInternetConnectionChecker());

    await GetIt.I.get<IMyConnectionChecker>().init();
  }

  if (!GetIt.I.isRegistered<Database>()) {
    final database = await openDatabase('database.db', version: 1, onCreate: (db, version) {
      db.batch()
        ..execute(SqfliteContactOfflineDataSource.createTable)
        ..commit();
    });

    GetIt.I.registerSingleton<Database>(database);
  }

  if (!GetIt.I.isRegistered<Dio>()) {
    GetIt.I.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: baseUrl)));
  }

  if (!GetIt.I.isRegistered<IContactOfflineDataSource>()) {
    GetIt.I.registerSingleton<IContactOfflineDataSource>(SqfliteContactOfflineDataSource());
    //GetIt.I.registerSingleton<IContactOfflineDataSource>(FakeContactOfflineDataSource());
  }
}
