part of 'contacts_cubit.dart';

abstract class ContactsState with EquatableMixin {
  const ContactsState({required this.contacts, required this.currentPage, required this.isLastPage, this.failure = const Failure.noFailure()});

  final List<Contact> contacts;
  final int currentPage;
  final bool isLastPage;
  final Failure failure;

  @override
  List<Object?> get props => [contacts, currentPage, isLastPage, failure];
}

class ContactsInitial extends ContactsState {
  const ContactsInitial() : super(contacts: const <Contact>[], currentPage: 0, isLastPage: false);
}

class ContactsListLoading extends ContactsState {
  ContactsListLoading(ContactsState previousState)
      : super(contacts: previousState.contacts, currentPage: previousState.currentPage, isLastPage: previousState.isLastPage);
}

class ContactsLoaded extends ContactsState {
  const ContactsLoaded({required super.contacts, required super.currentPage, required super.isLastPage});
}

class ContactsFailure extends ContactsState {
  ContactsFailure(ContactsState previousState, {required super.failure})
      : super(contacts: previousState.contacts, currentPage: previousState.currentPage, isLastPage: previousState.isLastPage);
}

class ContactsResetFailure extends ContactsState {
  ContactsResetFailure(ContactsState previousState)
      : super(contacts: previousState.contacts, currentPage: previousState.currentPage, isLastPage: previousState.isLastPage);
}
