import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/contact.dart';
import '../entities/meta.dart';
import '../entities/sync_status.dart';
import '../failures/unknown_failure.dart';
import '../services/result/result.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';
import 'contact_offline_datasource.dart';

class SqfliteContactOfflineDataSource implements IContactOfflineDataSource {
  SqfliteContactOfflineDataSource({Database? database, FlutterSecureStorage? keyValueDatabase})
      : _database = database ?? GetIt.I.get<Database>(),
        _keyValueDatabase = keyValueDatabase ?? GetIt.I.get<FlutterSecureStorage>();

  static const _contactsSynchronizedKey = 'contacts_synchronized_key';

  final Database _database;
  final FlutterSecureStorage _keyValueDatabase;

  static const createTable = '''
    CREATE TABLE ${Contact.tableName} (
      ${Contact.columnId} TEXT PRIMARY KEY,
      ${Contact.columnName} TEXT NOT NULL,
      ${Contact.columnAvatarUrl} TEXT,
      ${Contact.columnDocumentUrl} TEXT,
      ${Contact.columnDocumentPhonePath} TEXT,
      ${Contact.columnCreatedAt} TEXT NULL,
      ${Contact.columnUpdatedAt} TEXT NULL,
      ${Contact.columnSyncStatus} TEXT
    )''';

  @override
  Future<Result<({List<Contact> contacts, Meta meta})>> getAll({bool perPage = true, int page = 0}) async {
    Logger.pContactOfflineDataSource('getAll', {'perPage': perPage, 'page': page});

    try {
      final totalEntries =
          Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM ${Contact.tableName} WHERE ${Contact.columnSyncStatus}<>?', [
        SyncStatus.removed.name,
      ]));
      if (totalEntries == null || totalEntries == 0) {
        return const Success((
          contacts: [],
          meta: Meta.empty(),
        ));
      }

      // ignora os contatos com status removed
      final entries = perPage
          ? await _database.rawQuery('SELECT * FROM ${Contact.tableName} WHERE ${Contact.columnSyncStatus}<>? LIMIT ? OFFSET ?', [
              SyncStatus.removed.name,
              qtyContactsPerPage,
              qtyContactsPerPage * page,
            ])
          : await _database.rawQuery('SELECT * FROM ${Contact.tableName} WHERE ${Contact.columnSyncStatus}<>? LIMIT ?', [
              SyncStatus.removed.name,
              qtyContactsPerPage * (page + 1),
            ]);

      final totalPages = (totalEntries / qtyContactsPerPage).ceil();
      final isLastPage = (page + 1) == totalPages;

      return Success((
        contacts: entries.map<Contact>((query) => ContactExtension.fromMap(query)).toList(),
        meta: Meta(
          previousPage: page - 1,
          currentPage: page,
          nextPage: isLastPage ? -1 : page + 1,
          totalPages: totalPages,
          totalEntries: totalEntries,
        )
      ));
    } catch (e, s) {
      return Fail(UnknownFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Result<void>> setToRemoveAll({required DateTime? updatedAt, required SyncStatus syncStatus}) async {
    Logger.pContactOfflineDataSource('setToRemoveAll', {'updatedAt': updatedAt, 'syncStatus': syncStatus});

    try {
      await _database.rawUpdate(
        'UPDATE ${Contact.tableName} SET ${Contact.columnUpdatedAt}=?, ${Contact.columnSyncStatus}=?',
        [
          if (updatedAt == null) null else updatedAt.toIso8601String(),
          syncStatus.name,
        ],
      );

      return const SuccessOk();
    } catch (e, s) {
      return Fail(UnknownFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Result<Contact>> create(Contact contactToAdd) async {
    Logger.pContactOfflineDataSource('create', {'contactToAdd': contactToAdd});

    try {
      await _database.rawInsert(
          'INSERT INTO ${Contact.tableName}(${Contact.columnId}, ${Contact.columnName}, ${Contact.columnAvatarUrl}, ${Contact.columnDocumentUrl}, ${Contact.columnDocumentPhonePath}, ${Contact.columnCreatedAt}, ${Contact.columnUpdatedAt}, ${Contact.columnSyncStatus}) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
          [
            contactToAdd.id,
            contactToAdd.name,
            contactToAdd.avatarUrl,
            contactToAdd.documentUrl,
            contactToAdd.documentPhonePath,
            if (contactToAdd.createdAt == null) null else contactToAdd.createdAt!.toIso8601String(),
            if (contactToAdd.updatedAt == null) null else contactToAdd.updatedAt!.toIso8601String(),
            contactToAdd.syncStatus.name,
          ]);

      return Success(contactToAdd);
    } catch (e, s) {
      return Fail(UnknownFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Result<Contact>> update(Contact contactToEdit) async {
    Logger.pContactOfflineDataSource('update', {'contactToEdit': contactToEdit});

    try {
      await _database.rawUpdate(
        'UPDATE ${Contact.tableName} SET ${Contact.columnId}=?, ${Contact.columnName}=?, ${Contact.columnAvatarUrl}=?, ${Contact.columnDocumentUrl}=?, ${Contact.columnDocumentPhonePath}=?, ${Contact.columnCreatedAt}=?, ${Contact.columnUpdatedAt}=?, ${Contact.columnSyncStatus}=? WHERE ${Contact.columnId}=?',
        [
          contactToEdit.id,
          contactToEdit.name,
          contactToEdit.avatarUrl,
          contactToEdit.documentUrl,
          contactToEdit.documentPhonePath,
          if (contactToEdit.createdAt == null) null else contactToEdit.createdAt!.toIso8601String(),
          if (contactToEdit.updatedAt == null) null else contactToEdit.updatedAt!.toIso8601String(),
          contactToEdit.syncStatus.name,
          contactToEdit.id,
        ],
      );

      return Success(contactToEdit);
    } catch (e, s) {
      return Fail(UnknownFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Result<void>> setRemove(Contact contactToRemove) async {
    Logger.pContactOfflineDataSource('setRemove', {'contactToRemove': contactToRemove});

    try {
      await _database.rawUpdate(
        'UPDATE ${Contact.tableName} SET ${Contact.columnUpdatedAt}=?, ${Contact.columnSyncStatus}=? WHERE ${Contact.columnId}=?',
        [
          if (contactToRemove.updatedAt == null) null else contactToRemove.updatedAt!.toIso8601String(),
          contactToRemove.syncStatus.name,
          contactToRemove.id,
        ],
      );

      return const SuccessOk();
    } catch (e, s) {
      return Fail(UnknownFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Result<List<Contact>>> getAllDesynchronized() async {
    Logger.pContactOfflineDataSource('getAllDesynchronized');

    try {
      final entries = await _database.rawQuery('SELECT * FROM ${Contact.tableName} WHERE ${Contact.columnSyncStatus}<>?', [
        SyncStatus.synced.name,
      ]);

      return Success(entries.map<Contact>((entry) => ContactExtension.fromMap(entry)).toList());
    } catch (e, s) {
      return Fail(UnknownFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Result<void>> synchronizeList(List<Contact> contactsToSynchronize) async {
    Logger.pContactOfflineDataSource('synchronizeList', {'contactsToSynchronize': contactsToSynchronize});

    try {
      await _keyValueDatabase.write(key: _contactsSynchronizedKey, value: true.toString());

      final batch = _database.batch();
      for (final contact in contactsToSynchronize) {
        if (contact.syncStatus.isRemoved) {
          batch.rawDelete('DELETE FROM ${Contact.tableName} WHERE ${Contact.columnId}=?', [
            contact.id,
          ]);
        }

        if (contact.syncStatus.isAdded) {
          final qty = Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM ${Contact.tableName} WHERE ${Contact.columnId}=?', [
            contact.id,
          ]));
          final hasEntry = qty != null && qty == 1;

          if (hasEntry) {
            batch.rawUpdate(
              'UPDATE ${Contact.tableName} SET ${Contact.columnId}=?, ${Contact.columnName}=?, ${Contact.columnAvatarUrl}=?, ${Contact.columnDocumentUrl}=?, ${Contact.columnDocumentPhonePath}=?, ${Contact.columnCreatedAt}=?, ${Contact.columnUpdatedAt}=?, ${Contact.columnSyncStatus}=? WHERE ${Contact.columnId}=?',
              [
                contact.id,
                contact.name,
                contact.avatarUrl,
                contact.documentUrl,
                contact.documentPhonePath,
                if (contact.createdAt == null) null else contact.createdAt!.toIso8601String(),
                if (contact.updatedAt == null) null else contact.updatedAt!.toIso8601String(),
                SyncStatus.synced.name,
                contact.id,
              ],
            );
          } else {
            batch.rawInsert(
                'INSERT INTO ${Contact.tableName}(${Contact.columnId}, ${Contact.columnName}, ${Contact.columnAvatarUrl}, ${Contact.columnDocumentUrl}, ${Contact.columnDocumentPhonePath}, ${Contact.columnCreatedAt}, ${Contact.columnUpdatedAt}, ${Contact.columnSyncStatus}) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                [
                  contact.id,
                  contact.name,
                  contact.avatarUrl,
                  contact.documentUrl,
                  contact.documentPhonePath,
                  if (contact.createdAt == null) null else contact.createdAt!.toIso8601String(),
                  if (contact.updatedAt == null) null else contact.updatedAt!.toIso8601String(),
                  SyncStatus.synced.name,
                ]);
          }
        }

        batch.rawUpdate(
          'UPDATE ${Contact.tableName} SET ${Contact.columnId}=?, ${Contact.columnName}=?, ${Contact.columnAvatarUrl}=?, ${Contact.columnDocumentUrl}=?, ${Contact.columnDocumentPhonePath}=?, ${Contact.columnCreatedAt}=?, ${Contact.columnUpdatedAt}=?, ${Contact.columnSyncStatus}=? WHERE ${Contact.columnId}=?',
          [
            contact.id,
            contact.name,
            contact.avatarUrl,
            contact.documentUrl,
            contact.documentPhonePath,
            if (contact.createdAt == null) null else contact.createdAt!.toIso8601String(),
            if (contact.updatedAt == null) null else contact.updatedAt!.toIso8601String(),
            SyncStatus.synced.name,
            contact.id,
          ],
        );
      }
      await batch.commit();

      return const SuccessOk();
    } catch (e, s) {
      return Fail(UnknownFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<void> desynchronizeList() async {
    Logger.pContactOfflineDataSource('desynchronizeList');

    try {
      await _keyValueDatabase.write(key: _contactsSynchronizedKey, value: false.toString());
    } catch (e) {
      //
    }
  }

  @override
  Future<bool> isListSynchronized() async {
    Logger.pContactOfflineDataSource('isListSynchronized');
    try {
      final value = await _keyValueDatabase.read(key: _contactsSynchronizedKey);

      // quando inicia o app, o valor deve iniciar desincronizado com o servidor
      if (value == null) {
        await desynchronizeList();
        return false;
      }

      return value == true.toString();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isListNotSynchronized() async {
    Logger.pContactOfflineDataSource('isListNotSynchronized');

    return !(await isListSynchronized());
  }

  @override
  Future<void> printContacts({bool isShort = false}) async {
    final entries = await _database.rawQuery('SELECT * FROM ${Contact.tableName}');
    log('[');
    for (final contact in entries.map<Contact>((entry) => ContactExtension.fromMap(entry))) {
      log(isShort ? contact.toShortString() : contact.toString());
    }

    log(']');
  }
}
