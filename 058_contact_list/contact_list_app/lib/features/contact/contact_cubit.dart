import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/contact.dart';
import '../../failures/empty_name_validation_failure.dart';
import '../../repositories/contact_repository.dart';
import '../../services/result/failure.dart';
import '../../utils/logger.dart';
import '../../utils/strings.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit(Contact contact, {ContactRepository? repository})
      : _contactRepository = repository ?? ContactRepository(),
        super(ContactInitial(isNew: contact.hasNotData, originalContact: contact, temporaryAvatarFile: contact.avatarFile));

  final ContactRepository _contactRepository;

  Future<void> save({required String name, required String documentPhonePath}) async {
    Logger.pContactCubit('save', {'name': name, 'documentPhonePath': documentPhonePath});

    if (name.trim().isEmpty) {
      emit(ContactFailure(state, failure: const EmptyNameValidationFailure()));
      return;
    }

    emit(ContactLoading(state));

    if (state.isNew) {
      (await _contactRepository.add(name: name, temporaryAvatarFile: state.temporaryAvatarFile)).result((_) {
        emit(ContactLoaded(state, successMessage: Strings.contactAddMessage));
      }, (failure) {
        emit(ContactFailure(state, failure: failure));
      });
    } else {
      (await _contactRepository.edit(state.originalContact, name: name, temporaryAvatarFile: state.temporaryAvatarFile)).result((_) {
        emit(ContactLoaded(state, successMessage: Strings.contactEditMessage));
      }, (failure) {
        emit(ContactFailure(state, failure: failure));
      });
    }

    emit(ContactMessageReseted(state));
  }

  Future<void> delete() async {
    Logger.pContactCubit('delete');

    emit(ContactLoading(state));

    (await _contactRepository.delete(state.originalContact)).result((_) {
      emit(ContactLoaded(state, successMessage: Strings.contactDeleteMessage));
    }, (failure) {
      emit(ContactFailure(state, failure: failure));
    });

    emit(ContactMessageReseted(state));
  }

  Future<void> setTemporaryAvatar({required String temporaryAvatarPath}) async {
    Logger.pContactCubit('setTemporaryAvatar', {'temporaryAvatarPath': temporaryAvatarPath});

    try {
      if (temporaryAvatarPath.isNotEmpty) {
        emit(ContactLoaded(state, temporaryAvatarFile: File(temporaryAvatarPath)));
      }
    } catch (_) {
      // TODO
      emit(ContactFailure(state, failure: const Failure(tag: '', messageForUser: '')));
    }

    emit(ContactMessageReseted(state));
  }
}
