part of 'person_form_bloc.dart';

abstract class PersonFormEvent extends Equatable {
  const PersonFormEvent();

  @override
  List<Object> get props => [];
}

class NameUnfocused extends PersonFormEvent {}

class BirthdayUnfocused extends PersonFormEvent {}

class GenderUnfocused extends PersonFormEvent {}

class AddressUnfocused extends PersonFormEvent {}

class NameChanged extends PersonFormEvent {
  const NameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class BirthdayChanged extends PersonFormEvent {
  const BirthdayChanged(this.birthday);

  final String birthday;

  @override
  List<Object> get props => [birthday];
}

class GenderChanged extends PersonFormEvent {
  const GenderChanged(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class AddressChanged extends PersonFormEvent {
  const AddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class PictureChanged extends PersonFormEvent {
  const PictureChanged(this.picture);

  final File picture;

  @override
  List<Object> get props => [picture];
}

class FormSubmitted extends PersonFormEvent {}

class DeleteRequested extends PersonFormEvent {}
