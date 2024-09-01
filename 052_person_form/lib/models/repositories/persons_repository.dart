import 'package:person_form/controllers/repositories/persons_repository.dart';
import 'package:person_form/models/models/person.dart';
import 'package:person_form/models/services/api_service.dart';

class PersonsRepository implements IPersonsRepository {
  PersonsRepository(ApiService apiService) : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<List<Person>> getPersons() async {
    final partialPersons = await _apiService.getPersons();
    final fullPersons = await _apiService.getAvatarPictures(partialPersons);
    return fullPersons;
  }

  @override
  Future<List<Person>> getSuggestions() async {
    final partialPersons = await _apiService.getSuggestions();
    final fullPersons = await _apiService.getAvatarPictures(partialPersons);
    return fullPersons;
  }

  @override
  Future<List<Person>> getPersonsByQuery(String query) async {
    final partialPersons = await _apiService.getPersonsByQuery(query);
    final fullPersons = await _apiService.getAvatarPictures(partialPersons);
    return fullPersons;
  }
}
