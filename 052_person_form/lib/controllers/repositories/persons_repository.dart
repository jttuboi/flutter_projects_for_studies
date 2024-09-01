import 'package:person_form/models/models/person.dart';

abstract class IPersonsRepository {
  Future<List<Person>> getPersons();

  Future<List<Person>> getSuggestions();

  Future<List<Person>> getPersonsByQuery(String query);
}
