import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:person_form/models/models/person.dart';

class ApiService {
  final avatarFolder = 'avatars/';

  Future<List<Person>> getPersons() async {
    final collection = await FirebaseFirestore.instance.collection('persons').orderBy('name').get();
    return collection.docs.map((query) => Person.fromMap(query.id, query.data())).toList();
  }

  Future<List<Person>> getSuggestions() async {
    final collection = await FirebaseFirestore.instance.collection('persons').orderBy('name').limit(3).get();
    return collection.docs.map((query) => Person.fromMap(query.id, query.data())).toList();
  }

  Future<List<Person>> getPersonsByQuery(String query) async {
    // TODO: até onde pesquisei, o firestore não suporta pesquisa como LIKE do SQL
    // por enquanto a pesquisa tem que ser o nome inteiro
    // outra técnica é utilizar cache
    final collection = await FirebaseFirestore.instance.collection('persons').where('name', whereIn: [query]).get();
    return collection.docs.map((e) => Person.fromMap(e.id, e.data())).toList();
  }

  Future<void> save(Person person) async {
    await FirebaseFirestore.instance.collection('persons').add(person.toMap());
  }

  Future<void> update(Person person) async {
    await FirebaseFirestore.instance.collection('persons').doc(person.id).set(person.toMap());
  }

  Future<void> delete(Person person) async {
    await FirebaseFirestore.instance.collection('persons').doc(person.id).delete();
  }

  Future<void> saveAvatar(String filename, File picture) async {
    try {
      FirebaseStorage.instance.ref('$avatarFolder$filename').putFile(picture);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      print(e);
    }
  }

  Future<void> deleteAvatar(String filename) async {
    try {
      await FirebaseStorage.instance.ref('$avatarFolder$filename').delete();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      print(e);
    }
  }

  Future<List<Person>> getAvatarPictures(List<Person> persons) async {
    final newList = <Person>[];

    for (var person in persons) {
      if (person.avatarFilename.isEmpty) {
        newList.add(person);
        continue;
      }

      Directory appDocDir = await getApplicationDocumentsDirectory();
      File avatar = File('${appDocDir.path}/${person.avatarFilename}');

      try {
        await FirebaseStorage.instance.ref('$avatarFolder${person.avatarFilename}').writeToFile(avatar);
        newList.add(person.copyWith(picture: avatar));
      } on FirebaseException catch (e) {
        print(e);
      }
    }
    return newList;
  }
}
