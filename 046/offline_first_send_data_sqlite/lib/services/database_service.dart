import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyTable {
  const MyTable._();

  static const name = 'my_table';
  static const status = 'status';

  static const columnId = 'id';
  static const columnName = 'name';
}

class DatabaseService {
  static const _databaseName = "TestDatabase.db";
  static const _databaseVersion = 1;

  DatabaseService._privateConstructor();
  static final instance = DatabaseService._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print(path);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${MyTable.name} (
            ${MyTable.columnId} INTEGER PRIMARY KEY,
            ${MyTable.columnName} TEXT NOT NULL,
             ${MyTable.status} INT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(MyTable.name, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(MyTable.name);
  }

  //Get all records which are unsynched
  Future<List<Map<String, dynamic>>> queryUnsynchedRecords() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT id,name,status FROM ${MyTable.name} WHERE status = 0');
  }

  Future<List<Map<String, dynamic>>> queryAllRecords() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT id,name,status FROM ${MyTable.name}');
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${MyTable.name}')) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[MyTable.columnId];
    return await db.update(MyTable.name, row, where: '${MyTable.columnId} = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(MyTable.name, where: '${MyTable.columnId} = ?', whereArgs: [id]);
  }
}
