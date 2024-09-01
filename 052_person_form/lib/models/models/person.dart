import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  const Person({
    required this.id,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.address,
    required this.avatarFilename,
    this.picture,
  });

  final String id;
  final String name;
  final DateTime birthday;
  final String gender;
  final String address;
  final String avatarFilename;
  final File? picture;

  static Person empty = Person(
    id: '',
    name: '',
    birthday: DateTime(1900, 1, 1),
    gender: 'm',
    address: '',
    avatarFilename: '',
    picture: null,
  );

  Person copyWith({String? id, String? name, DateTime? birthday, String? gender, String? address, String? avatarFilename, File? picture}) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      avatarFilename: avatarFilename ?? this.avatarFilename,
      picture: picture ?? this.picture,
    );
  }

  @override
  List<Object?> get props => [id, name, birthday, gender, address, avatarFilename];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthday': Timestamp.fromMillisecondsSinceEpoch(birthday.millisecondsSinceEpoch),
      'gender': gender,
      'address': address,
      'avatarFilename': avatarFilename,
    };
  }

  factory Person.fromMap(String id, Map<String, dynamic> map) {
    return Person(
      id: id,
      name: map['name'],
      birthday: DateTime.fromMillisecondsSinceEpoch((map['birthday'] as Timestamp).millisecondsSinceEpoch),
      gender: map['gender'],
      address: map['address'],
      avatarFilename: map['avatarFilename'],
    );
  }
}
