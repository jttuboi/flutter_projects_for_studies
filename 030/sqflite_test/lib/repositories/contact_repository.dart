import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/models/contact_model.dart';
import 'package:sqflite_test/settings.dart';

class ContactRepository {
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) => db.execute(createContactsTableScript),
      version: 1,
    );
  }

  Future create(ContactModel model) async {
    try {
      final db = await _getDatabase();

      await db.insert(tableName, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return;
    }
  }

  Future<List<ContactModel>> getContacts() async {
    try {
      final db = await _getDatabase();
      final maps = await db.query(tableName);

      return List.generate(maps.length, (i) {
        return ContactModel(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          phone: maps[i]['phone'] as String,
          email: maps[i]['email'] as String,
          image: maps[i]['image'] as String,
          addressLine1: maps[i]['addressLine1'] as String,
          addressLine2: maps[i]['addressLine2'] as String,
          latLng: maps[i]['latLng'] as String,
        );
      });
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return <ContactModel>[];
    }
  }

  Future<List<ContactModel>> search(String term) async {
    try {
      final db = await _getDatabase();
      final maps = await db.query(tableName, where: "name LIKE ?", whereArgs: ['%$term%']);

      return List.generate(maps.length, (i) {
        return ContactModel(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          phone: maps[i]['phone'] as String,
          email: maps[i]['email'] as String,
          image: maps[i]['image'] as String,
          addressLine1: maps[i]['addressLine1'] as String,
          addressLine2: maps[i]['addressLine2'] as String,
          latLng: maps[i]['latLng'] as String,
        );
      });
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return <ContactModel>[];
    }
  }

  Future<ContactModel> getContact(int id) async {
    try {
      final db = await _getDatabase();
      final maps = await db.query(tableName, where: "id = ?", whereArgs: [id]);

      return ContactModel(
        id: maps[0]['id'] as int,
        name: maps[0]['name'] as String,
        phone: maps[0]['phone'] as String,
        email: maps[0]['email'] as String,
        image: maps[0]['image'] as String,
        addressLine1: maps[0]['addressLine1'] as String,
        addressLine2: maps[0]['addressLine2'] as String,
        latLng: maps[0]['latLng'] as String,
      );
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return ContactModel();
    }
  }

  Future update(ContactModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.update(tableName, model.toMap(), where: "id = ?", whereArgs: [model.id]);
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await _getDatabase();

      await db.delete(tableName, where: "id = ?", whereArgs: [id]);
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return;
    }
  }

  Future updateImage(int id, String imagePath) async {
    try {
      final Database db = await _getDatabase();
      final model = await getContact(id);

      model.image = imagePath;

      await db.update(tableName, model.toMap(), where: "id = ?", whereArgs: [model.id]);
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return;
    }
  }

  Future updateAddress(int id, String addressLine1, String addressLine2, String latLong) async {
    try {
      final Database db = await _getDatabase();
      final model = await getContact(id);

      model.addressLine1 = addressLine1;
      model.addressLine2 = addressLine2;
      model.latLng = latLong;

      await db.update(tableName, model.toMap(), where: "id = ?", whereArgs: [model.id]);
    } catch (e, s) {
      log('', error: e, stackTrace: s);
      return;
    }
  }
}
