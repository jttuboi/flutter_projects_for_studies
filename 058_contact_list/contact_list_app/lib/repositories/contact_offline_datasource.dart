import '../entities/contact.dart';
import '../entities/meta.dart';
import '../entities/sync_status.dart';
import '../services/result/result.dart';

abstract interface class IContactOfflineDataSource {
  Future<Result<({List<Contact> contacts, Meta meta})>> getAll({bool perPage = true, int page = 0});

  Future<Result<void>> setToRemoveAll({required DateTime? updatedAt, required SyncStatus syncStatus});

  Future<Result<Contact>> create(Contact contactToAdd);

  Future<Result<Contact>> update(Contact contactToEdit);

  Future<Result<void>> setRemove(Contact contactToRemove);

  Future<Result<List<Contact>>> getAllDesynchronized();

  Future<Result<void>> synchronizeList(List<Contact> contactsToSynchronize);

  Future<void> desynchronizeList();

  Future<bool> isListSynchronized();

  Future<bool> isListNotSynchronized();

  Future<void> printContacts({bool isShort = false});
}
