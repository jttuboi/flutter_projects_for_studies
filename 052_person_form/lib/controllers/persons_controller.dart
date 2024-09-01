import 'package:person_form/controllers/repositories/persons_repository.dart';
import 'package:person_form/models/models/person.dart';

class PersonsController {
  PersonsController(this._repository);

  final IPersonsRepository _repository;

  Future<List<Person>> getPersonsByQuery({String query = ''}) async {
    if (query.trim().isNotEmpty) {
      return await _repository.getPersonsByQuery(query.trim());
    }
    return await _repository.getPersons();
  }

  Future<List<Person>> getSuggestions() async {
    return await _repository.getSuggestions();
  }
}
