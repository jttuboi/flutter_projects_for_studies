import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:person_form/controllers/repositories/person_form_repository.dart';
import 'package:person_form/models/models/address.dart';
import 'package:person_form/models/models/birthday.dart';
import 'package:person_form/models/models/gender.dart';
import 'package:person_form/models/models/name.dart';
import 'package:person_form/models/models/person.dart';

part 'person_form_event.dart';
part 'person_form_state.dart';

class PersonFormBloc extends Bloc<PersonFormEvent, PersonFormState> {
  PersonFormBloc(IPersonFormRepository repository, Person person)
      : _repository = repository,
        super(person == Person.empty ? const PersonFormState() : newPersonFormStateForEdit(person)) {
    on<NameChanged>(_onNameChanged);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<GenderChanged>(_onGenderChanged);
    on<AddressChanged>(_onAddressChanged);
    on<PictureChanged>(_onPictureChanged);
    on<NameUnfocused>(_onNameUnfocused);
    on<BirthdayUnfocused>(_onBirthdayUnfocused);
    on<GenderUnfocused>(_onGenderUnfocused);
    on<AddressUnfocused>(_onAddressUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
    on<DeleteRequested>(_onDeleteRequested);
  }

  static PersonFormState newPersonFormStateForEdit(Person person) {
    return PersonFormState(
      id: person.id,
      name: Name.dirty(person.name),
      birthday: Birthday.dirty(Birthday.toScreenFormat(person.birthday)),
      gender: Gender.dirty(Gender.toScreenFormat(person.gender)),
      address: Address.dirty(person.address),
      avatarFilename: person.avatarFilename,
      picture: person.picture,
    );
  }

  final IPersonFormRepository _repository;

  void _onNameChanged(NameChanged event, Emitter<PersonFormState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name.valid ? name : Name.pure(event.name),
      status: Formz.validate([name, state.birthday, state.gender, state.address]),
    ));
  }

  void _onBirthdayChanged(BirthdayChanged event, Emitter<PersonFormState> emit) {
    final birthday = Birthday.dirty(event.birthday);
    emit(state.copyWith(
      birthday: birthday.valid ? birthday : Birthday.pure(event.birthday),
      status: Formz.validate([state.name, birthday, state.gender, state.address]),
    ));
  }

  void _onGenderChanged(GenderChanged event, Emitter<PersonFormState> emit) {
    final genders = [false, false];
    genders[event.index] = true;

    final gender = Gender.dirty(genders);
    emit(state.copyWith(
      gender: gender.valid ? gender : Gender.pure(genders),
      status: Formz.validate([state.name, state.birthday, gender, state.address]),
    ));
  }

  void _onAddressChanged(AddressChanged event, Emitter<PersonFormState> emit) {
    final address = Address.dirty(event.address);
    emit(state.copyWith(
      address: address.valid ? address : Address.pure(event.address),
      status: Formz.validate([state.name, state.birthday, state.gender, address]),
    ));
  }

  void _onPictureChanged(PictureChanged event, Emitter<PersonFormState> emit) {
    emit(state.copyWith(
      picture: event.picture,
      status: Formz.validate([state.name, state.birthday, state.gender, state.address]),
    ));
  }

  void _onNameUnfocused(NameUnfocused event, Emitter<PersonFormState> emit) {
    final name = Name.dirty(state.name.value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.birthday, state.gender, state.address]),
    ));
  }

  void _onBirthdayUnfocused(BirthdayUnfocused event, Emitter<PersonFormState> emit) {
    final birthday = Birthday.dirty(state.birthday.value);
    emit(state.copyWith(
      birthday: birthday,
      status: Formz.validate([state.name, birthday, state.gender, state.address]),
    ));
  }

  void _onGenderUnfocused(GenderUnfocused event, Emitter<PersonFormState> emit) {
    final gender = Gender.dirty(state.gender.value);
    emit(state.copyWith(
      gender: gender,
      status: Formz.validate([state.name, state.birthday, gender, state.address]),
    ));
  }

  void _onAddressUnfocused(AddressUnfocused event, Emitter<PersonFormState> emit) {
    final address = Address.dirty(state.address.value);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([state.name, state.birthday, state.gender, address]),
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<PersonFormState> emit) async {
    final name = Name.dirty(state.name.value);
    final birthday = Birthday.dirty(state.birthday.value);
    final gender = Gender.dirty(state.gender.value);
    final address = Address.dirty(state.address.value);
    emit(state.copyWith(
      name: name,
      birthday: birthday,
      gender: gender,
      address: address,
      avatarFilename: state.avatarFilename,
      picture: state.picture,
      status: Formz.validate([name, birthday, gender, address]),
    ));

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await _repository.save(Person(
        id: state.id,
        name: state.name.value,
        birthday: state.birthday.toDateTime(),
        gender: state.gender.toGender(),
        address: state.address.value,
        avatarFilename: state.avatarFilename,
        picture: state.picture,
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }

  void _onDeleteRequested(DeleteRequested event, Emitter<PersonFormState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    await _repository.delete(Person(
      id: state.id,
      name: state.name.value,
      birthday: state.birthday.toDateTime(),
      gender: state.gender.toGender(),
      address: state.address.value,
      avatarFilename: state.avatarFilename,
      picture: state.picture,
    ));
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }
}
