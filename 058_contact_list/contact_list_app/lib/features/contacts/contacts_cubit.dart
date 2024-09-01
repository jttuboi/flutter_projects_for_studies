import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import '../../entities/contact.dart';
import '../../failures/internet_unavailable_failure.dart';
import '../../failures/unknown_failure.dart';
import '../../repositories/contact_repository.dart';
import '../../services/connection_checker/connection_checker.dart';
import '../../services/open/open.dart';
import '../../services/result/failure.dart';
import '../../utils/logger.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit({IMyConnectionChecker? connectionChecker, ContactRepository? repository})
      : _connectionChecker = connectionChecker ?? GetIt.I.get<IMyConnectionChecker>(),
        _repository = repository ?? ContactRepository(),
        super(const ContactsInitial());

  final IMyConnectionChecker _connectionChecker;
  final ContactRepository _repository;

  Future<void> init() async {
    Logger.pContactsCubit('init');

    await _getAll(page: 0);

    _connectionChecker.addListener(_synchronizeWhenInternetGotBack);
  }

  Future<void> _synchronizeWhenInternetGotBack() async {
    await updateList();
  }

  // a diferença entre update e refresh list é que o primeiro mantém a página, o segundo pega a lista do zero
  Future<void> updateList() async {
    Logger.pContactsCubit('updateList');

    await _repository.synchronize();

    await _getAll(perPage: false, page: state.currentPage);
  }

  Future<void> refreshList() async {
    Logger.pContactsCubit('refreshList');

    emit(const ContactsInitial());

    await _repository.synchronize();

    await _getAll(page: 0);
  }

  Future<void> getMore() async {
    Logger.pContactsCubit('getMore');

    emit(ContactsListLoading(state));

    final nextPage = state.currentPage + 1;

    await _getAll(oldContacts: state.contacts, page: nextPage);
  }

  Future<void> deleteAll() async {
    Logger.pContactsCubit('deleteAll');

    (await _repository.deleteAll()).result((_) {
      emit(const ContactsLoaded(contacts: <Contact>[], currentPage: 0, isLastPage: true));
    }, (failure) {
      emit(ContactsFailure(state, failure: failure));
      emit(ContactsResetFailure(state));
    });
  }

  Future<void> delete(Contact contact) async {
    Logger.pContactsCubit('delete', {'contact': contact});

    (await _repository.delete(contact)).result((_) {
      updateList();
    }, (failure) {
      emit(ContactsFailure(state, failure: failure));
      emit(ContactsResetFailure(state));
    });
  }

  Future<void> openDocument(Contact contact) async {
    Logger.pContactsCubit('openDocument', {'contact': contact});

    if (contact.documentPhonePath.isNotEmpty) {
      await Open.pdf(phonePath: contact.documentPhonePath);
      return;
    }

    await DefaultCacheManager().getSingleFile(contact.documentUrl).then((file) async {
      final documentPhonePath = file.path;
      final index = state.contacts.indexWhere((c) => c.id == contact.id);
      final contactUpdated = contact.copyWith(documentPhonePath: documentPhonePath);

      // atualiza o database
      // await _repository.edit(contactUpdated);

      // atualizar a tela
      state.contacts[index] = contactUpdated;
      emit(ContactsLoaded(contacts: state.contacts, currentPage: state.currentPage, isLastPage: state.isLastPage));

      await Open.pdf(phonePath: documentPhonePath);
    }).onError((error, stackTrace) {
      if (error is SocketException) {
        emit(ContactsFailure(state, failure: const InternetUnavailableFailure()));
      } else {
        emit(ContactsFailure(state, failure: const UnknownFailure()));
      }
      emit(ContactsResetFailure(state));
    });
  }

  Future<void> _getAll({List<Contact> oldContacts = const <Contact>[], bool perPage = true, required int page}) async {
    (await _repository.getAll(page: page, perPage: perPage)).result((r) {
      emit(ContactsLoaded(contacts: [...oldContacts, ...r.contacts], currentPage: page, isLastPage: r.meta.isLastPage));
    }, (failure) {
      emit(ContactsFailure(state, failure: failure));
      emit(ContactsResetFailure(state));
    });
  }

  @override
  void emit(ContactsState state) {
    //Logger.pContactsCubit('emit', {'state': state});

    super.emit(state);
  }

  @override
  Future<void> close() {
    _connectionChecker.removeListener(_synchronizeWhenInternetGotBack);
    return super.close();
  }
}
