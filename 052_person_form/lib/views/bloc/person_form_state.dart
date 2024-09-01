part of 'person_form_bloc.dart';

class PersonFormState extends Equatable {
  const PersonFormState({
    this.id = '',
    this.name = const Name.pure(),
    this.birthday = const Birthday.pure(),
    this.gender = const Gender.pure(),
    this.address = const Address.pure(),
    this.avatarFilename = '',
    this.picture,
    this.status = FormzStatus.pure,
  });

  final String id;
  final Name name;
  final Birthday birthday;
  final Gender gender;
  final Address address;
  final String avatarFilename;
  final File? picture;
  final FormzStatus status;

  PersonFormState copyWith({
    String? id,
    Name? name,
    Birthday? birthday,
    Gender? gender,
    Address? address,
    String? avatarFilename,
    File? picture,
    FormzStatus? status,
  }) {
    return PersonFormState(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      avatarFilename: avatarFilename ?? this.avatarFilename,
      picture: picture ?? this.picture,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [id, name, birthday, gender, address, avatarFilename, status];
}
