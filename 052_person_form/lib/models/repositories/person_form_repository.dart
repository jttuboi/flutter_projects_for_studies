import 'package:path/path.dart';
import 'package:person_form/controllers/repositories/person_form_repository.dart';
import 'package:person_form/models/models/person.dart';
import 'package:person_form/models/services/api_service.dart';

class PersonFormRepository implements IPersonFormRepository {
  PersonFormRepository(ApiService apiService) : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<void> save(Person person) async {
    if (person.id.isEmpty) {
      await _create(person);
    } else {
      await _udpate(person);
    }
  }

  Future<void> _create(Person person) async {
    String filename = '';

    if (person.picture != null) {
      filename = 'avatar-${DateTime.now().toString()}.jpg';
      await _apiService.saveAvatar(filename, person.picture!);
    }

    await _apiService.save(person.copyWith(avatarFilename: filename));
  }

  Future<void> _udpate(Person person) async {
    if (person.picture == null) {
      // se nao tem imagem
      if (person.avatarFilename.isNotEmpty) {
        await _apiService.deleteAvatar(person.avatarFilename);
      }
      await _apiService.update(person.copyWith(avatarFilename: ''));
    } else if (basename(person.picture!.path) != person.avatarFilename) {
      // se mudou de imagem
      await _apiService.deleteAvatar(person.avatarFilename);

      String newFilename = 'avatar-${DateTime.now().toString()}.jpg';
      await _apiService.saveAvatar(newFilename, person.picture!);
      await _apiService.update(person.copyWith(avatarFilename: newFilename));
    } else {
      // se tem a imagem e nao foi atualizada
      await _apiService.update(person);
    }
  }

  @override
  Future<void> delete(Person person) async {
    if (person.avatarFilename.isNotEmpty) {
      await _apiService.deleteAvatar(person.avatarFilename);
    }
    await _apiService.delete(person);
  }
}
