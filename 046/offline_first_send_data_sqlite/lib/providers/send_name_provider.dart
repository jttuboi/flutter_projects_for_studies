import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:offline_first_send_data_sqlite/model/name_model.dart';
import 'package:offline_first_send_data_sqlite/services/database_service.dart';

class SendNameProvider with ChangeNotifier {
  final _dbHelper = DatabaseService.instance;

  final _items = <NameModel>[];
  List<NameModel> get items {
    return [..._items];
  }

  final _defaultOptions = Options(headers: {HttpHeaders.contentTypeHeader: "application/json"});

  Future<void> sync(text, connectionStatus) async {
    print(text.toString());
    int a = 1;
    print(connectionStatus.toString());
    try {
      if (connectionStatus) {
        final response = await Dio().post('http://192.168.42.175/SqliteSync/saveName.php',
            options: _defaultOptions,
            data: jsonEncode(<String, dynamic>{
              "name": text.toString(),
              "status": a,
            }));
        if (response.statusCode == 200) {
          final body = response.statusMessage;
          print(body);
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      } else {}

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addName(text, connectionStatus) async {
    print(text.toString());
    int a = 1;
    print(connectionStatus.toString());
    try {
      if (connectionStatus) {
        final response = await Dio().post('http://192.168.42.175/SqliteSync/saveName.php',
            options: _defaultOptions,
            data: jsonEncode(<String, dynamic>{
              "name": text.toString(),
              "status": a,
            }));
        // final http.Response response = await http.post(
        //   ' http://localhost/SqliteSync/saveName.php',
        //   headers: <String, String>{
        //     'Content-Type': 'application/json; charset=UTF-8',
        //   },
        //   body: jsonEncode(<String, dynamic>{
        //     "name": text.toString(),
        //     "status": a
        //   }),
        // );

        // [4] quando envia o novo dados para o servidor, se salvou ele responde com ok e deve atualizar os dados da base para sincronizado (status == 1)
        // senão deve atualizar a base de dados do msm jeito, mas para base com dados desincronizados (status == 0)
        if (response.statusCode == 200) {
          final body = response.statusMessage!;
          print(body);
          final row = <String, dynamic>{
            MyTable.columnName: text.toString(),
            MyTable.status: 1,
          };
          await _dbHelper.insert(row);
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      } else {
        final row = <String, dynamic>{
          MyTable.columnName: text.toString(),
          MyTable.status: 0,
        };
        final id = await _dbHelper.insert(row);
        print('inserted row id: $id');
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
