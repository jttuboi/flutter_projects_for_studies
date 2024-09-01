import 'dart:io';

import '../entities/contact.dart';
import '../services/result/result.dart';

abstract interface class IContactOnlineDataSource {
  Future<Result<List<Contact>>> synchronize(List<Contact> contactsDesynchronized, Map<String, File> files);

  Future<Result<bool>> hasDataToSynchronize();

  Future<Result<List<Contact>>> getAll();

  // Future<Result<void>> deleteAll();

  // Future<Result<Contact>> get(String id);

  // Future<Result<Contact>> create(Contact contactToAdd);

  // Future<Result<Contact>> update(Contact contactToEdit);

  // Future<Result<void>> delete(Contact contactToRemove);
}
