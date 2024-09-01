import 'dart:async';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../entities/contact.dart';
import '../entities/meta.dart';
import '../entities/sync_status.dart';
import '../services/connection_checker/connection_checker.dart';
import '../services/result/result.dart';
import '../utils/logger.dart';
import 'contact_offline_datasource.dart';
import 'contact_online_datasource.dart';
import 'dio_contact_online_datasource.dart';

class ContactRepository {
  ContactRepository(
      {IMyConnectionChecker? connectionChecker, IContactOnlineDataSource? onlineDataSource, IContactOfflineDataSource? offlineDataSource})
      : _connectionChecker = connectionChecker ?? GetIt.I.get<IMyConnectionChecker>(),
        _onlineDataSource = onlineDataSource ?? DioContactOnlineDataSource(),
        _offlineDataSource = offlineDataSource ?? GetIt.I.get<IContactOfflineDataSource>();

  final IMyConnectionChecker _connectionChecker;
  final IContactOnlineDataSource _onlineDataSource;
  final IContactOfflineDataSource _offlineDataSource;

  ///
  /// synchronize local database with server
  ///
  Future<Result<void>> synchronize() async {
    Logger.pContactRepository('synchronize');

    if (!_connectionChecker.hasConnection) {
      // não retorna erro, pois o problema é a falta de internet e não um erro em si.
      // como é necessário internet para sincronizar, não há o pq tentar sincronizar.
      return const SuccessOk();
    }

    if (await _offlineDataSource.isListSynchronized()) {
      return const SuccessOk();
    }

    return (await _offlineDataSource.getAllDesynchronized()).result(
      (contactsDesynchronized) async {
        // se não tem nenhum dado na base local ao sincronizar, pode ser uma nova instalação do app ou alguma coisa inconsistente q limpou a base local,
        // então é necessário verificar se o servidor tem os dados para pegar o "backup".
        if (contactsDesynchronized.isEmpty) {
          return (await _onlineDataSource.hasDataToSynchronize()).result(
            (hasDataToSynchronize) async {
              // se tem data para sincronizar, então recupera tudo e sincroniza com a base local
              if (hasDataToSynchronize) {
                return (await _onlineDataSource.getAll()).result(
                  (contactsSynchronized) async {
                    return (await _offlineDataSource.synchronizeList(contactsSynchronized)).result(
                      (_) => const SuccessOk(),
                      (failure) async => Fail(failure),
                    );
                  },
                  (failure) async => Fail(failure),
                );
              }

              // se não tem data para sincronizar, então apenas finaliza a sincronização
              return (await _offlineDataSource.synchronizeList(const [])).result(
                (_) async => const SuccessOk(),
                (failure) async => Fail(failure),
              );
            },
            (failure) async => Fail(failure),
          );
        }

        final files = <String, File>{};
        for (final contactDesynchronized in contactsDesynchronized) {
          final imageKey = contactDesynchronized.id;
          final fileInfo = await DefaultCacheManager().getFileFromCache(imageKey);
          if (fileInfo != null) {
            files[imageKey] = fileInfo.file;
          }
        }

        return (await _onlineDataSource.synchronize(contactsDesynchronized, files)).result(
          (contactsSynchronized) async {
            return (await _offlineDataSource.synchronizeList(contactsSynchronized)).result(
              (_) async => const SuccessOk(),
              (failure) async => Fail(failure),
            );
          },
          (failure) async => Fail(failure),
        );
      },
      (failure) async => Fail(failure),
    );
  }

  ///
  /// get partial contacts using page
  ///
  Future<Result<({List<Contact> contacts, Meta meta})>> getAll({bool perPage = true, int page = 0}) async {
    Logger.pContactRepository('getAll', {'perPage': perPage, 'page': page});

    return (await _offlineDataSource.getAll(perPage: perPage, page: page)).result((r) async {
      final contactsUpdated = <Contact>[];

      for (final contactToUpdate in r.contacts) {
        contactsUpdated.add(await _getContactWithAvatarFromCache(contactToUpdate));
      }

      return Success((
        contacts: contactsUpdated,
        meta: r.meta,
      ));
    }, (failure) {
      return Fail(failure);
    });
  }

  ///
  /// set to delete all contacts from local database to late synchronize
  /// obs: after call this, must call synchronize
  ///
  Future<Result<void>> deleteAll() async {
    Logger.pContactRepository('deleteAll');

    // refaz os contatos para status removed
    return (await _offlineDataSource.setToRemoveAll(updatedAt: DateTime.now(), syncStatus: SyncStatus.removed)).result(
      (_) async {
        // desincroniza para posteriormente atualizar a lista através da sincronização
        await _offlineDataSource.desynchronizeList();

        return const SuccessOk();
      },
      (failure) => Fail(failure),
    );
  }

  ///
  /// add contact to local database to late synchronize
  /// obs: after call this, must call synchronize
  ///
  Future<Result<void>> add({required String name, required File? temporaryAvatarFile}) async {
    Logger.pContactRepository('add', {'name': name, 'temporaryAvatarFile': temporaryAvatarFile?.path});

    final newId = const Uuid().v4();

    final contactBeforeAddAvatar = Contact(
      id: newId,
      // TODO precisa ver sobre qndo atualizar esses campos
      avatarUrl: '',
      documentUrl: '',
      name: name,
      createdAt: DateTime.now(),
      syncStatus: SyncStatus.added,
    );

    final contactToAdd = await _addAvatarToCache(contactBeforeAddAvatar, temporaryAvatarFile: temporaryAvatarFile);

    // salva o contato na base local
    return (await _offlineDataSource.create(contactToAdd)).result(
      (_) async {
        // desincroniza para posteriormente atualizar a lista através da sincronização
        await _offlineDataSource.desynchronizeList();

        return const SuccessOk();
      },
      (failure) async => Fail(failure),
    );
  }

  ///
  /// update contact to local database to late synchronize
  /// obs: after call this, must call synchronize
  ///
  Future<Result<void>> edit(Contact originalContact, {required String name, required File? temporaryAvatarFile}) async {
    Logger.pContactRepository('edit', {'originalContact': originalContact, 'name': name, 'temporaryAvatarFile': temporaryAvatarFile?.path});

    final contactBeforeUpdateAvatar = originalContact.copyWith(
      name: name,
      updatedAt: DateTime.now(),
      syncStatus: SyncStatus.updated,
    );

    final contactToUpdate = await _updateAvatarInCache(contactBeforeUpdateAvatar, temporaryAvatarFile: temporaryAvatarFile);

    // atualiza o contato na base local
    return (await _offlineDataSource.update(contactToUpdate)).result(
      (_) async {
        // desincroniza para posteriormente atualizar a lista através da sincronização
        await _offlineDataSource.desynchronizeList();

        return const SuccessOk();
      },
      (failure) async => Fail(failure),
    );
  }

  ///
  /// set to delete contact from local database to late synchronize
  /// obs: after call this, must call synchronize
  ///
  Future<Result<void>> delete(Contact contactToDelete) async {
    Logger.pContactRepository('delete', {'contact': contactToDelete});

    // refazer o contact para status removed
    final contactToRemove = contactToDelete.copyWith(
      updatedAt: DateTime.now(),
      syncStatus: SyncStatus.removed,
    );

    // deleta o contato na base local
    return (await _offlineDataSource.setRemove(contactToRemove)).result(
      (_) async {
        // desincroniza para posteriormente atualizar a lista através da sincronização
        await _offlineDataSource.desynchronizeList();

        return const SuccessOk();
      },
      (failure) async => Fail(failure),
    );
  }

  Future<Contact> _getContactWithAvatarFromCache(Contact contact) async {
    final imageKey = contact.id;

    final fileInfo = await DefaultCacheManager().getFileFromCache(imageKey);

    return contact.copyWith(avatarFile: fileInfo?.file);
  }

  Future<Contact> _addAvatarToCache(Contact contact, {String avatarUrl = '', required File? temporaryAvatarFile}) async {
    File? avatarFileToAdd;

    // se tiver avatar adicionado na tela, então adiciona ele no cache
    if (temporaryAvatarFile != null) {
      final imageKey = contact.id;

      final uint8List = await temporaryAvatarFile.readAsBytes();
      avatarFileToAdd = await DefaultCacheManager().putFile(avatarUrl, uint8List, key: imageKey);
    }

    return contact.copyWith(avatarUrl: avatarUrl, avatarFile: avatarFileToAdd);
  }

  Future<Contact> _updateAvatarInCache(Contact contact, {String avatarUrl = '', required File? temporaryAvatarFile}) async {
    var avatarFileToUpdate = temporaryAvatarFile;

    // se mudou o path, então atualiza ele no cache
    if (contact.avatarFile?.path != avatarFileToUpdate?.path) {
      final imageKey = contact.id;

      if (avatarFileToUpdate != null) {
        await DefaultCacheManager().removeFile(imageKey);

        final uint8List = await avatarFileToUpdate.readAsBytes();
        avatarFileToUpdate = await DefaultCacheManager().putFile(avatarUrl, uint8List, key: imageKey);
      } else {
        // se não tem temporário, então ele removeu da tela
        await DefaultCacheManager().removeFile(imageKey);
        avatarFileToUpdate = null;
      }
    }

    return contact.copyWith(avatarUrl: avatarUrl, avatarFile: avatarFileToUpdate);
  }
}
