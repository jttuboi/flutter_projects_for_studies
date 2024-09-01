import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:offline_first_send_data_sqlite/providers/send_name_provider.dart';
import 'package:offline_first_send_data_sqlite/services/database_service.dart';
import 'package:offline_first_send_data_sqlite/widgets/widgets.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SendNameProvider(),
        ),
      ],
      child: const MaterialApp(
        home: MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _dbHelper = DatabaseService.instance;

  final _text = TextEditingController();

  // simula a data q é mostrada na tela
  final _listOfScreen = [];

  // simula o status da conexão atual
  bool _connectionStatus = false;

  @override
  void initState() {
    super.initState();
    // [1] inicia recuperando todos dados
    _getAllDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final nameProvider = Provider.of<SendNameProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(title: const Text("SQLite")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              OfflineBuilder(
                connectivityBuilder: (_, connectivity, child) {
                  // [2] a checagem da conexão começa aqui
                  _connectionStatus = connectivity != ConnectivityResult.none;
                  if (_connectionStatus) {
                    // [2.1] se tem conexão, então começa sincronizar
                    _syncItNow(context, _connectionStatus);
                  }
                  return Stack(children: [child]);
                },
                builder: (_) => const SizedBox(),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(
                    children: <Widget>[
                      // [6] deleta o ultimo e atualiza a tela
                      Button('delete', onPressed: _delete),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                child: TextField(
                                    controller: _text,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter the Value', border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10))),
                              ),
                            ),
                            Button('Submit', style: MyButtonStyle.red, onPressed: () {
                              setState(() {
                                // [3] envia o dado para o servidor, nessa etapa também
                                // se o servidor salvou os dados, é atualizado a base local para (status == 1)
                                // senão, é atualizado a base local para (status == 0) (q está desincronizado)
                                nameProvider.addName(_text.text, _connectionStatus).then((value) {
                                  _text.clear();
                                  _getAllDataFromDatabase();
                                });
                              });
                            }),
                          ],
                        ),
                      ),
                      // [5] esses parece q é apenas teste para atualizar a lista
                      Button('query', onPressed: _query),
                      Button('Query Unsync', onPressed: _getUnsynchedRecords),
                      SizedBox(
                          height: 400.0,
                          child: ListView.builder(
                            itemCount: _listOfScreen.length,
                            itemBuilder: (_, i) => ListTile(
                              title: Text(_listOfScreen[i]['name']),
                              trailing: (_listOfScreen[i]['status'] != 0) ? const Icon(Icons.check) : const Icon(Icons.clear),
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _getAllDataFromDatabase() async {
    // [1.1] limpa lista da tela
    _listOfScreen.clear();

    // [1.2] recupera dados da base local e adiciona na lista da tela
    var allRows = await _queryAllRecordsFromDatabase();
    allRows.forEach((row) async {
      _listOfScreen.add(row);
    });
    setState(() {});
  }

  Future<dynamic> _queryAllRecordsFromDatabase() async {
    final allData = await _dbHelper.queryAllRecords();
    print('query all unsynched:');
    return allData;
  }

  void _insert() async {
    // row to insert
    // Map<String, dynamic> row = {
    //   DatabaseHelper.columnName : 'Bob',
    //   DatabaseHelper.columnAge  : 23
    // };
    // final id = await dbHelper.insert(row);
    // print('inserted row id: $id');
  }

  Future<void> _syncItNow(BuildContext context, bool connectionStatus) async {
    final nameProvider = Provider.of<SendNameProvider>(context, listen: false);

    // [2.2] recupera dados desincronizados da base local (status == 0)
    // ou seja, q possívelmente não está salvo no servidor
    var allRows = await _getUnsynchedRecords();

    allRows.forEach((row) async {
      // [2.3] atualiza o servidor
      await nameProvider.sync(row['name'], connectionStatus);

      // [2.4] atualiza a base de dados para status sincronizado (status == 1)
      final rowsAffected = await _dbHelper.update({
        MyTable.status: 1,
        MyTable.columnId: row['id'],
        MyTable.columnName: row['name'],
      });
      print('updated $rowsAffected row(s)');
    });
  }

  Future<dynamic> _getUnsynchedRecords() async {
    final allRows = await _dbHelper.queryUnsynchedRecords();
    print('query all unsynched:');
    for (var row in allRows) {
      print(row);
    }
    return allRows;
  }

  void _query() async {
    final allRows = await _dbHelper.queryAllRows();
    print('query all rows:');
    for (var row in allRows) {
      print(row);
    }
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await _dbHelper.queryRowCount();
    final rowsDeleted = await _dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');

    setState(() {
      _getAllDataFromDatabase();
    });
  }
}
