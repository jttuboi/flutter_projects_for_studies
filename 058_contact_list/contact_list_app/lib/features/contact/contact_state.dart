part of 'contact_cubit.dart';

abstract class ContactState with EquatableMixin {
  const ContactState({
    required this.isNew,
    required this.originalContact,
    this.temporaryAvatarFile,
    this.successMessage = '',
    this.failure = const Failure.noFailure(),
  });

  final bool isNew;
  final Contact originalContact;
  final File? temporaryAvatarFile;
  final String successMessage;
  final Failure failure;

  @override
  List<Object?> get props => [isNew, originalContact, temporaryAvatarFile, successMessage, failure];

  bool get isEdit => !isNew;
}

class ContactInitial extends ContactState {
  const ContactInitial({super.isNew = true, super.originalContact = const Contact.noData(), required super.temporaryAvatarFile});
}

class ContactLoading extends ContactState {
  ContactLoading(ContactState previousState)
      : super(isNew: previousState.isNew, originalContact: previousState.originalContact, temporaryAvatarFile: previousState.temporaryAvatarFile);
}

class ContactLoaded extends ContactState {
  ContactLoaded(ContactState previousState, {super.successMessage = '', super.temporaryAvatarFile})
      : super(isNew: previousState.isNew, originalContact: previousState.originalContact);
}

class ContactMessageReseted extends ContactState {
  ContactMessageReseted(ContactState previousState)
      : super(isNew: previousState.isNew, originalContact: previousState.originalContact, temporaryAvatarFile: previousState.temporaryAvatarFile);
}

class ContactFailure extends ContactState {
  ContactFailure(ContactState previousState, {required super.failure})
      : super(isNew: previousState.isNew, originalContact: previousState.originalContact, temporaryAvatarFile: previousState.temporaryAvatarFile);
}

class ContactValidationFailure extends ContactState {
  ContactValidationFailure(ContactState previousState, {required super.failure})
      : super(isNew: previousState.isNew, originalContact: previousState.originalContact, temporaryAvatarFile: previousState.temporaryAvatarFile);
}
